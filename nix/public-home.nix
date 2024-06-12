
{ pkgs, ... }:
{

  home = {
    packages = with pkgs; [
      ripgrep # grep alternative
    ];
  };
}
