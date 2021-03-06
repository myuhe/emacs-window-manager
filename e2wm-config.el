;;; e2wm-config.el --- e2wm configuration

;; Copyright (C) 2010, 2011  SAKURAI Masashi

;; Author: SAKURAI Masashi <m.sakurai@kiwanami.net>
;; Version: 1.0
;; Keywords: tools, window manager

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; sample configuration
;; コメントアウトされているものはデフォルトの設定

;;; Code:

(setq woman-use-own-frame nil) ; womanで新規フレームを開かせない

;; (setq e2wm:prefix-key "C-c ; ")

(require 'e2wm)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 全体設定

;; (setq e2wm:debug nil) 

;; (setq e2wm:c-max-history-num 20)  ; 履歴の保存数

;; (setq e2wm:c-recordable-buffer-p  ; 履歴として記録したいBuffer
;;       (lambda (buf)
;;         (buffer-local-value 'buffer-file-name buf))) ; ファイル名に関連ついてるもの

;; (setq e2wm:c-document-buffer-p ; 
;;       (lambda (buf)
;;         (string-match "\\*\\(Help\\|info\\|w3m\\|WoMan\\)" 
;;                       (buffer-name buf)))) ; ドキュメント的に扱いたいバッファ

;; (setq e2wm:c-blank-buffer         ; 白紙バッファ
;;       (let ((buf (get-buffer-create " *e2wm:blank*")))
;;         (with-current-buffer buf
;;           (setq buffer-read-only nil)
;;           (buffer-disable-undo buf)
;;           (erase-buffer)
;;           (setq buffer-read-only t)) buf))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; パースペクティブカスタマイズ

;;; code

;; ;; レイアウト

;; ;; for 1440x900以上 (default)
;; (setq e2wm:c-code-recipe
;;   '(| (:left-max-size 35)
;;       (- (:upper-size-ratio 0.7)
;;          files history)
;;       (- (:upper-size-ratio 0.7)
;;          (| (:right-max-size 30)
;;             main imenu)
;;          sub)))

;; ;; for 1280x768
;; (setq e2wm:c-code-recipe
;;   '(| (:left-max-size 30)
;;       (- (:upper-size-ratio 0.7)
;;          files history)
;;       (- (:upper-size-ratio 0.7)
;;          (| (:right-max-size 25)
;;             main imenu)
;;          sub)))

;; ;; for 1024x768
;; (setq e2wm:c-code-recipe
;;   '(| (:left-max-size 35)
;;       (- (:upper-size-ratio 0.7)
;;          (- (:upper-size-ratio 0.6)
;;             files imenu)
;;          history)
;;       (- (:upper-size-ratio 0.7)
;;          main sub)))

;; (setq e2wm:c-code-winfo
;;   '((:name main)
;;     (:name files :plugin files)
;;     (:name history :plugin history-list)
;;     (:name sub :buffer "*info*" :default-hide t)
;;     (:name imenu :plugin imenu :default-hide nil))
;;   )

;; ;; メインに表示していいもの（それ以外はSubに表示される）
;; (setq e2wm:c-code-show-main-regexp
;;    "\\*\\(vc-diff\\)\\*")

;; キーバインド
(e2wm:add-keymap 
 e2wm:pst-minor-mode-keymap
 '(("<M-left>" . e2wm:dp-code) ; codeへ変更
   ("<M-right>"  . e2wm:dp-two)  ; twoへ変更
   ("<M-up>"    . e2wm:dp-doc)  ; docへ変更
   ("<M-down>"  . e2wm:dp-dashboard) ; dashboardへ変更
   ("C-."       . e2wm:pst-history-forward-command) ; 履歴を進む
   ("C-,"       . e2wm:pst-history-back-command) ; 履歴をもどる
   ("prefix L"  . ielm)
   ("M-m"       . e2wm:pst-window-select-main-command)
   ) e2wm:prefix-key)

;;; two

;; ;; レイアウト
;; (setq e2wm:c-two-recipe
;;       '(- (:upper-size-ratio 0.8)
;;           (| left
;;              (- (:upper-size-ratio 0.9)
;;                 right history))
;;           sub))

;; (setq e2wm:c-two-winfo
;;       '((:name left )
;;         (:name right )
;;         (:name sub :buffer "*Help*" :default-hide t)
;;         (:name history :plugin history-list :default-hide nil)))

;; デフォルトで右側に何を表示するかの設定。
;; * left : 左右同じバッファ
;; * prev : バッファ履歴のひとつ前
;; (setq e2wm:c-two-right-default 'left) ; left, prev

;; キーバインド
(e2wm:add-keymap 
 e2wm:dp-two-minor-mode-map 
 '(("prefix I" . info)
   ("C->"       . e2wm:dp-two-right-history-forward-command) ; 右側の履歴を進む
   ("C-<"       . e2wm:dp-two-right-history-back-command) ; 右側の履歴を進む
   ) e2wm:prefix-key)

;;; doc

;; ;; レイアウト
;; (setq e2wm:c-doc-recipe
;;       '(- (:upper-size-ratio 0.75)
;;         (| left right)
;;         sub))

;; (setq e2wm:c-doc-winfo
;;       '((:name left)
;;         (:name right)
;;         (:name sub :default-hide t)))

;; キーバインド
(e2wm:add-keymap 
 e2wm:dp-doc-minor-mode-map 
 '(("prefix I" . info)) 
 e2wm:prefix-key)

;;; dashboard

(setq e2wm:c-dashboard-plugins
  '(clock top
    (open :plugin-args (:command eshell :buffer "*eshell*"))
    (open :plugin-args (:command doctor :buffer "*doctor*"))
    ))

;;; pstset



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; プラグインカスタマイズ

;;; top

;; (setq e2wm:def-plugin-top-timer-interval 20 "Seconds for update.")

;;; clock

;; (defvar e2wm:def-plugin-clock-download-file "/tmp/wmclock.jpg"  "[internal]")
;; (defvar e2wm:def-plugin-clock-resized-file  "/tmp/wmclockt.jpg" "[internal]")
;;↑cygwin環境の場合は "C:/cygwin/tmp/wmclock.jpg" とかにすると良いかも

;; for bijin (default)
;; (setq e2wm:def-plugin-clock-url "http://www.bijint.com/jp/img/clk/%H%M.jpg")
;; (setq e2wm:def-plugin-clock-referer "http://www.bijint.com/jp/")

;; for binan
;; (setq e2wm:def-plugin-clock-url "http://www.bijint.com/binan/tokei_images/%H%M.jpg")
;; (setq e2wm:def-plugin-clock-referer "http://www.bijint.com/binan/")

;; for circuit
;; (setq e2wm:def-plugin-clock-url "http://www.bijint.com/cc/tokei_images/%H%M.jpg")
;; (setq e2wm:def-plugin-clock-referer "http://www.bijint.com/cc/")

;; for fukuoka (maybe the other places...)
;; (setq e2wm:def-plugin-clock-url "http://www.bijint.com/fukuoka/tokei_images/%H%M.jpg")
;; (setq e2wm:def-plugin-clock-referer "http://www.bijint.com/fukuoka/")
;; see the site -> http://www.bijint.com/jp/pages/tokei/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 機能干渉対応

;;; For emacsclient

;; server-start を実行した後に、follow-mode を実行すると emacsclient と
;; の通信が出来なくなる。follow-mode が emacsclient のソケットプロセス
;; の入力を捨ててしまうことが原因。

;; 対策(1)
;; follow-intercept-processes を nil にすると、 follow-mode のプロセス
;; 乗っ取りを止めることが出来るが、外部プロセスの入力によって
;; follow-modeの位置がずれていくことがあるかもしれない。

(setq follow-intercept-processes nil)

;; 対策(2)
;; follow-intercept-processes を nil にしたくない場合は、以下のように
;; follow-modeの関数を乗っ取ることでうまく動く。ただし、 follow-mode の
;; 実装が今後変わった場合には、動作は保証されない。

;; (eval-after-load "follow-mode"
;;   (defun follow-intercept-process-output ()
;;     "Intercept all active processes (Overrided by e2wm)."
;;     (interactive)
;;     (let ((list (process-list)))
;;       (while list
;;         (if (or (eq (process-filter (car list)) 'follow-generic-filter)
;;                 (eq (car list) server-process)) ; <- see the source at "server.el"
;;             nil
;;           (set-process-filter (car list) (process-filter (car list))))
;;         (setq list (cdr list))))
;;     (setq follow-intercept-processes t))
;;   )

;;; For moccur

;; moccurの検索結果バッファでエンター（moccur-mode-goto-occurrence, moccur-grep-goto）し
;; たときの挙動を改善する。また、マッチのプレビュー表示でカーソールが移
;; 動しない問題はgoto-lineでウインドウの位置を修正するようにアドバイス。

(eval-after-load "color-moccur"
  '(progn

     (defadvice moccur-mode-goto-occurrence (around e2wm:ad-override)
       ad-do-it
       (delete-window (selected-window)) ; Enterでmoccurのバッファを消す（消さない方が良ければこの行をコメント）
       (e2wm:pst-window-select-main))

     (defadvice moccur-grep-goto (around e2wm:ad-override)
       ad-do-it
       (delete-window (selected-window)) ; Enterでmoccurのバッファを消す（消さない方が良ければこの行をコメント）
       (e2wm:pst-window-select-main))
     
     (defadvice goto-line (around e2wm:ad-override)
       ad-do-it
       (let ((buf (or (ad-get-arg 2) (current-buffer))))
         (when (and
                (e2wm:managed-p)
                (eq (wlf:get-window (e2wm:pst-get-wm) 'sub) (selected-window))
                (not (eql (selected-window) (get-buffer-window buf))))
           (set-window-point 
            (get-buffer-window buf)
            (with-current-buffer buf (point))))))

     (when (e2wm:managed-p)
       (ad-activate-regexp "^e2wm:ad-override$"))
     ))

;;; For widen-window.el

;; widen-window.el と e2wm を同時に使うとEmacsがエラーで入力を受け付け
;; なくなってしまう。widen-window.elがアドバイスで乗っ取る関数と e2wm
;; が乗っ取る関数がかぶっていることが原因。以下のコメントされたコードを
;; 実行すると、e2wmのフレームではwiden-window.elが動作しないように回避
;; する。

;; (eval-after-load "widen-window"
;;   '(progn
;;      (defun e2wm:fix-widen-window-pre-start ()
;;
;;        ;; widen-window でエラーを起きないようする
;;        (defadvice wlf:layout-internal (around disable-ww-mode activate)
;;          (ad-deactivate-regexp "widen-window")
;;          (unwind-protect
;;              ad-do-it
;;            (ad-activate-regexp "widen-window")))
;;
;;        ;; widen-window を e2wm では全く使わない場合
;;        (defadvice widen-current-window (around e2wm:disable-ww-mode activate)
;;          (unless (e2wm:managed-p)
;;            ad-do-it
;;            )))
;;
;;      (defun e2wm:fix-widen-window-post-stop ()
;;        ;; e2wm が終わったら widen-window を戻す
;;        (ad-deactivate-regexp "e2wm:disable-ww-mode"))
;;
;;      (defun e2wm:fix-widen-window ()
;;        (interactive)
;;        (when (featurep 'widen-window)
;;          (add-hook 'e2wm:pre-start-hook 'e2wm:fix-widen-window-pre-start)
;;          (add-hook 'e2wm:post-stop-hook 'e2wm:fix-widen-window-post-stop))
;;        )
;;
;;      (e2wm:fix-widen-window)))

;;; For elscreen.el

;; elscreen.el は e2wm と同じく、フレーム内のウインドウの挙動を監視し、
;; ウインドウの状態を保存、復帰している。そのため、スクリーン（タブ）
;; を作ると、e2wmはウインドウを管理できなくなる。デフォルトの状態では、
;; スクリーンを複数作らなければelscreen.el自体を動かすことについては
;; 特に問題はない。

;; 回避方法としては、elscreenの管理オブジェクトの中にe2wmの管理オブジェ
;; クトを入れてelscreenの傘下に入るという方法を行う。これにより、
;; elscreenごとに異なる異なるe2wmインスタンスを持つ頃が出来る。
;; （e2wmの所々でグローバルで値を共有しているところがあるので今後直す）

(eval-after-load "elscreen" 
  '(progn
     ;; overrides storages for elscreen
     (defadvice e2wm:frame-param-get (around e2wm:ad-override-els (name &optional frame))
       ;; frame is not used...
       (e2wm:message "** e2wm:frame-param-get : %s " name)
       (let ((alst (cdr (assq 'e2wm-frame-prop
                              (elscreen-get-screen-property 
                               (elscreen-get-current-screen))))))
         (setq ad-return-value (and alst (cdr (assq name alst))))))
     (defadvice e2wm:frame-param-set (around e2wm:ad-override-els (name val &optional frame))
       (e2wm:message "** e2wm:frame-param-set : %s / %s" name val)
       (let* ((screen (elscreen-get-current-screen))
              (screen-prop (elscreen-get-screen-property screen))
              (alst (cdr (assq 'e2wm-frame-prop screen-prop))))
         (set-alist 'alst name val)
         (set-alist 'screen-prop 'e2wm-frame-prop alst)
         (elscreen-set-screen-property screen screen-prop)
         (setq ad-return-value val)))
     ;; grab switch events
     (defun e2wm:elscreen-define-advice (function)
       (eval 
        `(defadvice ,function (around e2wm:ad-override-els)
           (e2wm:message "** %s vvvv" ',function)
           (when (e2wm:managed-p)
             (e2wm:message "** e2wm:managed")
             (let ((it (e2wm:pst-get-instance)))
               (e2wm:pst-method-call e2wm:$pst-class-leave it (e2wm:$pst-wm it)))
             (e2wm:pst-minor-mode -1))
           (e2wm:message "** ad-do-it ->")
           ad-do-it
           (e2wm:message "** ad-do-it <-")
           (e2wm:message "** e2wm:param %s" 
                         (cdr (assq 'e2wm-frame-prop
                                    (elscreen-get-screen-property 
                                     (elscreen-get-current-screen)))))
           (when (e2wm:managed-p)
             (e2wm:message "** e2wm:managed")
             (let ((it (e2wm:pst-get-instance)))
               (e2wm:pst-method-call e2wm:$pst-class-start it (e2wm:$pst-wm it)))
             (e2wm:pst-minor-mode 1))
           (e2wm:message "** %s ^^^^^" ',function)
           )))
     (defadvice elscreen-create (around e2wm:ad-override-els)
       (let (default-wcfg)
         (when (e2wm:managed-p)
           (loop for screen in (reverse (sort (elscreen-get-screen-list) '<))
                 for alst = (cdr (assq 'e2wm-frame-prop
                                       (elscreen-get-screen-property screen)))
                 for wcfg = (and alst (cdr (assq 'e2wm-save-window-configuration alst)))
                 if wcfg
                 do (setq default-wcfg wcfg) (return)))
         ad-do-it
         (when default-wcfg
           (set-window-configuration default-wcfg))))

     ;; apply defadvices to some elscreen functions
     (loop for i in '(elscreen-goto 
                      elscreen-kill 
                      elscreen-clone
                      elscreen-swap)
           do (e2wm:elscreen-define-advice i))
     (defun e2wm:elscreen-override ()
       (ad-activate-regexp "^e2wm:ad-override-els$")
       (setq e2wm:override-window-ext-managed t))
     (defun e2wm:elscreen-revert ()
       (ad-deactivate-regexp "^e2wm:ad-override-els$")
       (setq e2wm:override-window-ext-managed nil))
     ;; start and exit
     (add-hook 'e2wm:pre-start-hook 'e2wm:elscreen-override)
     (add-hook 'e2wm:post-stop-hook 'e2wm:elscreen-revert)
     ))

;;; For Multi Term

;; Multi Term は「dedicated」なウインドウを消さないような、簡易ウインド
;; ウ管理の仕組みを持っている。実装としてはウインドウ系のアドバイスがい
;; くつか入っている。MultiTermはe2wmとそういった点でウインドウ管理の機
;; 能が重複する。そのため、共存が難しいのでウインドウ系のアドバイスにつ
;; いてはe2wm管理下では無効にする。とりあえず完全に機能が競合する
;; delete-other-windowsだけ無効にする。

(eval-after-load "multi-term"
  '(progn

     (defun e2wm:mult-term-advices-disable ()
       (ad-disable-advice 'delete-other-windows 'around 'multi-term-delete-other-window-advice))
     (defun e2wm:mult-term-advices-enable ()
       (ad-enable-advice  'delete-other-windows 'around 'multi-term-delete-other-window-advice))
     
     (add-hook 'e2wm:pst-minor-mode-setup-hook 'e2wm:mult-term-advices-disable)
     (add-hook 'e2wm:pst-minor-mode-abort-hook 'e2wm:mult-term-advices-enable)
     ))

(provide 'e2wm-config)
;;; e2wm-config.el ends here
