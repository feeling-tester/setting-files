(setq inhibit-startup-message t) ;; オープニングメッセージを表示しない
(setq-default c-basic-offset 2     ;;基本インデント量4
              tab-width 2          ;;タブ幅4
              indent-tabs-mode nil)  ;;インデントをタブでするかスペースでするか

;; 対応する括弧をハイライトする
(show-paren-mode 1)

;; 対応する括弧の色の設定
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")

;; 予約語を色分けする
(global-font-lock-mode t)

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

(if window-system (progn

  ;; 文字の色を設定します。
  (add-to-list 'default-frame-alist '(foreground-color . "white"))
  ;; 背景色を設定します。
  (add-to-list 'default-frame-alist '(background-color . "black"))
  ;; カーソルの色を設定します。
  (add-to-list 'default-frame-alist '(cursor-color . "SlateBlue2"))
  ;; マウスポインタの色を設定します。
  (add-to-list 'default-frame-alist '(mouse-color . "SlateBlue2"))
  ;; モードラインの文字の色を設定します。
  (set-face-foreground 'mode-line "black")
  ;; モードラインの背景色を設定します。
  (set-face-background 'mode-line "gray")
  ;; 選択中のリージョンの色を設定します。
  (set-face-background 'region "LightSteelBlue1")
  ;; モードライン（アクティブでないバッファ）の文字色を設定します。
  (set-face-foreground 'mode-line-inactive "gray30")
  ;; モードライン（アクティブでないバッファ）の背景色を設定します。
  (set-face-background 'mode-line-inactive "gray85")
))



(define-key global-map (kbd "C-c C-i") 'hippie-expand)    ; 補完

;;; 補完
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;;; 部分一致の補完機能を使う
;;; p-bでprint-bufferとか
;;;;; (partial-completion-mode t)

;; 補完可能なものを随時表示
(icomplete-mode 1)



(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))))


;; Auto Complete

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ
(setq ac-delay 0.05)  ;; n秒後に補完開始
(setq ac-use-comphist t)  ;; 補完推測機能有効
(setq ac-auto-show-menu 0.05)  ;; n秒後に補完メニューを表示
(setq ac-ignore-case nil)  ;; 大文字・小文字を区別する

;; 行数表示
(global-linum-mode t)
(setq linum-format "%4d|")
(put 'upcase-region 'disabled nil)

;; (require 'auto-complete)
;; (require 'auto-complete-config)    ; 必須ではないですが一応
;; (global-auto-complete-mode t)

;; ;; zencoding-mode
;; (defconst my-elisp-directory "~/.emacs.d/elisp" "The directory for my elisp file.")

;; (dolist (dir (let ((dir (expand-file-name my-elisp-directory)))
;;                (list dir (format "%s%d" dir emacs-major-version))))
;;   (when (and (stringp dir) (file-directory-p dir))
;;     (let ((default-directory dir))
;;       (add-to-list 'load-path default-directory)
;;       (normal-top-level-add-subdirs-to-load-path))))

;; (require 'zencoding-mode)
;; (add-hook 'sgml-mode-hook 'zencoding-mode)
;; (define-key zencoding-mode-keymap (kbd "C-i") 'zencoding-expand-line)
(defun setup-ac-for-haml ()
  ;; Require ac-haml since we are setup haml auto completion
  (require 'ac-haml)
  ;; Require default data provider if you want to use
  (require 'ac-html-default-data-provider)
  ;; Enable data providers,
  ;; currently only default data provider available
  (ac-html-enable-data-provider 'ac-html-default-data-provider)
  ;; Let ac-haml do some setup
  (ac-haml-setup)
  ;; Set your ac-source
  (setq ac-sources '(ac-source-haml-tag
                     ac-source-haml-attr
                     ac-source-haml-attrv))
  ;; Enable auto complete mode
  (auto-complete-mode))

(add-hook 'haml-mode-hook 'setup-ac-for-haml)


;; パスを指定
(add-to-list 'load-path "~/.emacs.d/vendor")

(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

;; インデント幅を2にする
;; コンパイルは compass watchで行うので自動コンパイルをオフ
(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
          '(lambda() (scss-custom)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; モードラインに列番号を表示
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(column-number-mode t)
(line-number-mode t) 


;; web mode
;; http://web-mode.org/
;; http://yanmoo.blogspot.jp/2013/06/html5web-mode.html
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.ctp\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; web-modeの設定
(defun web-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-engines-alist
        '(("php"    . "\\.ctp\\'"))
        )
  )

(add-hook 'web-mode-hook  'web-mode-hook)

;; 色の設定
(custom-set-faces
 '(web-mode-doctype-face
   ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face
   ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-html-attr-name-face
   ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face
   ((t (:foreground "#82AE46"))))
 '(web-mode-comment-face
   ((t (:foreground "#D9333F"))))
 '(web-mode-server-comment-face
   ((t (:foreground "#D9333F"))))
 '(web-mode-css-rule-face
   ((t (:foreground "#A0D8EF"))))
 '(web-mode-css-pseudo-class-face
   ((t (:foreground "#FF7F00"))))
 '(web-mode-css-at-rule-face
   ((t (:foreground "#FF7F00"))))
)



;; Latex
(autoload 'yatex-mode "yatex" "yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
		("\\.ltx$" . yatex-mode)
		("\\.cls$" . yatex-mode)
		("\\.sty$" . yatex-mode)
		("\\.clo$" . yatex-mode)
		("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-kanji-code nil)
(setq tex-command "platex")
(setq dvi2-command "xdvi")
(setq tex-pdfview-command "evince")
(setq bibtex-command "pbibtex")
(setq dviprint-command-format "dvipdfmx")
(add-hook 'yatex-mode-hook '(lambda () (auto-fill-mode -1)))
(add-hook 'yatex-mode-hook 'turn-on-reftex)


(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ
(setq ac-delay 0.05)  ;; n秒後に補完開始
(setq ac-use-comphist t)  ;; 補完推測機能有効
(setq ac-auto-show-menu 0.05)  ;; n秒後に補完メニューを表示
(setq ac-ignore-case nil)  ;; 大文字・小文字を区別する
(global-set-key [f3] 'complete-tag) 
(global-auto-complete-mode t)


;; ; yasnippetを置いているフォルダにパスを通す
;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/elpa/yasnippet-20161026.1601"))

;; ;;自分用のスニペットフォルダと，拾ってきたスニペットフォルダの2つを作っておきます．
;; ;;(一つにまとめてもいいけど)
;; (require 'yasnippet)

;; (setq yas-snippet-dirs
;;       '("~/.emacs.d/mySnippets" 
;;         "~/.emacs.d/snippets"
;;         ))

;; ;; 既存スニペットを挿入する
;; (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; ;; 新規スニペットを作成するバッファを用意する
;; (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; ;; 既存スニペットを閲覧・編集する
;; (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

;; (yas-global-mode t)

(require 'tramp)
(setq tramp-default-method "ssh")
