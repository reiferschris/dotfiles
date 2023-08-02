
{ config, pkgs, lib, ... }: {

home.file.nvim = { 
  target = ".config/nvim/";
  recursive = true;
  source = "../config/nvim/";
  };
}
