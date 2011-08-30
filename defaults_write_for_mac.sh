#!/bin/sh

# .DS_Store を作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Dashboard を利用停止
defaults write com.apple.dashboard mcx-disabled -boolean YES

# stack をリスト表記を大きくする
defaults write com.apple.dock use-new-list-stack -boolean true

# リストにマウスオーバー時にハイライト
defaults write com.apple.dock mouse-over-hilite-stack -boolean true

# 印刷、保存時のデフォルトを詳細設定
defaults write -g NSNavPanelExpandedStateForSaveMode -boolean true

# スクリーンショットの保存先変更
#defaults write com.apple.screencapture location ~/ScreenCapture

# デスクトップにアイコンを表示させない
#defaults write com.apple.finder CreateDesktop -boolean false

# Finderウィンドウのタイトル部分にそのウィンドウのパスを表示させる
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES

# Bonjor による検索を有効化
defaults write  com.apple.ScreenSharing ShowBonjourBrowser_Debug 1
# 画面共有のほかの機能達
#defaults write  com.apple.ScreenSharing   \
#   'NSToolbar Configuration ControlToolbar' -dict-add 'TB Item Identifiers' \
#      '(Scale,Control,Share,Curtain,Capture,FullScreen,GetClipboard,SendClipboard,Quality)'
      

# Safari のデバッグメニューを使えるようにする
defaults write com.apple.Safari IncludeDebugMenu 1

# SafariでWebインスペクタ機能を使えるようにする
defaults write com.apple.Safari WebKitDeveloperExtras -bool true

#0(無効)〜3(強)の4段階のアンチエイリアスの強度で、2か3がオススメ
#defaults -currentHost write -globalDomain AppleFontSmoothing -int 3

killall Dock
