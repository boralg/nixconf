{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    autosuggestion.strategy = [
      "history"
      "completion"
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k.zsh;
        file = "p10k.zsh";
      }
    ];

    initContent = ''
      [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}

      setopt AUTO_PUSHD
    '';

    history.size = 10000;

    shellAliases = {
    };

    dirHashes = {
      projs = "$HOME/Desktop/projs";
    };
  };
}
