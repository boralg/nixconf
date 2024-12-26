{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "services/org.kde.krunner.desktop"."_launch" = [
        "Alt+F2"
        "Alt+Space"
        "Search"
      ];

      "services/org.kde.spectacle.desktop"."ActiveWindowScreenShot" = "Ctrl+Print";
      "services/org.kde.spectacle.desktop"."CurrentMonitorScreenShot" = "Print";
      "services/org.kde.spectacle.desktop"."FullScreenScreenShot" = "Meta+Print";
      "services/org.kde.spectacle.desktop"."RecordWindow" = [ ];
      "services/org.kde.spectacle.desktop"."RectangularRegionScreenShot" = "Meta+Shift+S";
      "services/org.kde.spectacle.desktop"."_launch" = [ ];
    };
    configFile = {
      "baloofilerc"."General"."dbVersion" = 2;
      "baloofilerc"."General"."exclude filters version" = 5;
      "baloofilerc"."General"."first run" = false;
      "baloofilerc"."General"."folders[$e]" = "/";
      "baloofilerc"."General"."index hidden folders" = true;
      "baloofilerc"."General"."only basic indexing" = true;

      "dolphinrc"."DetailsMode"."IconSize" = 64;
      "dolphinrc"."IconsMode"."PreviewSize" = 80;
      "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      "dolphinrc"."PreviewSettings"."Plugins" = "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mltpreview,mobithumbnail,opendocumentthumbnail,aseprite,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs";

      "kcminputrc"."Libinput/0/14373/ USB OPTICAL MOUSE"."PointerAcceleration" = "-0.200";
      "kcminputrc"."Libinput/0/14373/ USB OPTICAL MOUSE"."PointerAccelerationProfile" = 1;
      "kcminputrc"."Libinput/1241/63015/USB Gaming Mouse"."PointerAcceleration" = 0.000;
      "kcminputrc"."Libinput/1241/63015/USB Gaming Mouse"."PointerAccelerationProfile" = 1;
      "kcminputrc"."Libinput/1267/12521/ELAN1205:00 04F3:30E9 Touchpad"."DisableWhileTyping" = true;
      "kcminputrc"."Libinput/1267/12521/ELAN1205:00 04F3:30E9 Touchpad"."Enabled" = true;
      "kcminputrc"."Libinput/1267/12521/ELAN1205:00 04F3:30E9 Touchpad"."NaturalScroll" = true;
      "kcminputrc"."Libinput/1267/12521/ELAN1205:00 04F3:30E9 Touchpad"."PointerAcceleration" = 0.000;
      "kcminputrc"."Libinput/1267/12521/ELAN1205:00 04F3:30E9 Touchpad"."PointerAccelerationProfile" = 1;
      "kcminputrc"."Libinput/1267/12521/ELAN1205:00 04F3:30E9 Touchpad"."ScrollMethod" = 1;
      "kcminputrc"."Mouse"."X11LibInputXAccelProfileFlat" = true;
      "kcminputrc"."Mouse"."XLbInptPointerAcceleration" = "-0.2";

      "kdeglobals"."General"."BrowserApplication" = "firefox.desktop";
      "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
      "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
      "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
      "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
      "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
      "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
      "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
      "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
      "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
      "kdeglobals"."KFileDialog Settings"."Show hidden files" = false;
      "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
      "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
      "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 138;
      "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
      "kdeglobals"."PreviewSettings"."EnableRemoteFolderThumbnail" = true;
      "kdeglobals"."PreviewSettings"."MaximumRemoteSize" = 209715200;
      "kdeglobals"."WM"."activeBackground" = "49,54,59";
      "kdeglobals"."WM"."activeBlend" = "252,252,252";
      "kdeglobals"."WM"."activeForeground" = "252,252,252";
      "kdeglobals"."WM"."inactiveBackground" = "42,46,50";
      "kdeglobals"."WM"."inactiveBlend" = "161,169,177";
      "kdeglobals"."WM"."inactiveForeground" = "161,169,177";

      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "/nix/store/c6c1w2k7kyqckg24p4p4x4fgpqwpwp20-breeze-6.0.5/share/wallpapers/Next/";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" = "/nix/store/c6c1w2k7kyqckg24p4p4x4fgpqwpwp20-breeze-6.0.5/share/wallpapers/Next/";
    };
    dataFile = {
      "dolphin/view_properties/global/.directory"."Dolphin"."PreviewsShown" = true;
      "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
    };
  };
}
