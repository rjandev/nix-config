{ config, lib, pkgs, self, ... }:
with lib;
let
  versions = builtins.fromJSON (readFile (./versions.json));
  customizeJetbrains = map (pkg:
    (pkg.override ({
      # increase memory
      vmopts = ''
        -server
        -Xms2048m
        -Xmx8192m
      '';
    })).overrideAttrs (attrs:
      # replace version with the one specified above if it is newer
      let v = versions.linux.${attrs.pname} or { };
      in if v != { } && v.version > attrs.version then rec {
        version = v.version;
        src = pkgs.fetchurl rec {
          url = (lib.replaceStrings [ attrs.version ] [ v.version ] attrs.src.url);
          sha256 = v.sha256;
        };
      } else
        attrs));
in {

  imports = [ ];
  environment = {
    systemPackages = with pkgs;
      customizeJetbrains ([
        (jetbrains.idea-ultimate.overrideAttrs (oldAttrs: rec {
          src = pkgs.fetchurl rec { url = (lib.replaceStrings [ "-no-jbr" ] [ "" ] oldAttrs.src.url); };
        }))
        #(jetbrains.goland.overrideAttrs (oldAttrs: rec { postFixup = ""; }))
        #        (jetbrains.clion.overrideAttrs (oldAttrs: rec {
        #          # copied from original and added lldb fix
        #          postFixup = lib.optionalString (stdenv.isLinux) ''
        #            (
        #              cd $out/clion
        #              # bundled cmake does not find libc
        #              rm -rf bin/cmake/linux
        #              ln -s ${cmake} bin/cmake/linux
        #              # bundled gdb does not find libcrypto 10
        #              rm -rf bin/gdb/linux
        #              ln -s ${gdb} bin/gdb/linux
        #              # bundled lldb does not find dependencies
        #              rm -rf bin/lldb/linux
        #              ln -s ${lldb} bin/lldb/linux
        #
        #              autoPatchelf $PWD/bin
        #              wrapProgram $out/bin/clion \
        #                --set CL_JDK "${jdk}"
        #            )
        #          '';
        #        }))
        #jetbrains.pycharm-professional
        #jetbrains.webstorm
      ]);
  };

}
