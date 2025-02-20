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

    dirHashes = {
      projs = "$HOME/Desktop/projs";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };

    history.size = 10000;

    shellAliases = {
    };
  };
}
