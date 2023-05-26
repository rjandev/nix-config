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
      # replace version with the one from versions.json
      let v = versions.linux.${attrs.pname} or { };
      in if v != { } then rec {
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
      ]);
  };

}
