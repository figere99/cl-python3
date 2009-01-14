;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CLPYTHON; Readtable: PY-AST-USER-READTABLE -*-
;; 
;; This software is Copyright (c) Franz Inc. and Willem Broekema.
;; Franz Inc. and Willem Broekema grant you the rights to
;; distribute and use this software as governed by the terms
;; of the Lisp Lesser GNU Public License
;; (http://opensource.franz.com/preamble.html),
;; known as the LLGPL.

;;;; Habitat: "Where the snakes live"

(in-package :clpython)
(in-syntax *user-readtable*)

(defclass habitat ()
  ((stdin           :initform *standard-input*
		    :initarg :stdin
		    :accessor habitat-stdin)
   (stdout          :initform *standard-output*
		    :initarg :stdout
		    :accessor habitat-stdout)
   (stderr          :initform *error-output* 
		    :initarg :stderr
		    :accessor habitat-stderr)
   #+(or) ;; unused
   (search-paths    :initarg :search-paths
		    :initform ()
		    :accessor habitat-search-paths)
   (loaded-mods     :initform ()
		    :initarg :loaded-mods   
		    :accessor habitat-loaded-mods
		    :documentation "List of modules")
   (autoload-p      :initform :builtin
		    :initarg :autoload-p
		    :accessor habitat-autoload-p
		    :documentation "Whether modules are imported automatically")
   (comp-mode       :initform nil
		    :initarg :debug
		    :accessor habitat-debug
		    :documentation "Module compilation mode"))
  (:documentation "Python execution context"))

(defun make-habitat (&rest options)
  (apply #'make-instance 'habitat options))

(defun get-loaded-module (&key src-pathname bin-pathname
                               src-file-write-date bin-file-write-date
                               habitat)
  (check-type habitat habitat)
  (loop for m in (habitat-loaded-mods habitat)
      when (and (or (null src-pathname)
                    (progn (check-type src-pathname pathname)
                           (equal (module-src-pathname m) src-pathname)))
                (or (null bin-pathname)
                    (progn (check-type bin-pathname pathname)
                           (equal (module-bin-pathname m) bin-pathname)))
                (or (null src-file-write-date)
                    (= (module-src-file-write-date m) src-file-write-date))
                (or (null bin-file-write-date)
                    (= (module-bin-file-write-date m) bin-file-write-date)))
      return m))

(defun add-loaded-module (module habitat)
  (check-type module module)
  (check-type habitat habitat)
  ;; In general, don't remove the old module with same pathnames:
  ;; when re-import goes wrong, the new failed module is popped,
  ;; so the old one is available again.
  (push module (habitat-loaded-mods habitat)))

(defun remove-loaded-module (&rest args &key habitat &allow-other-keys)
  (whereas ((m (apply #'get-loaded-module args)))
    (setf (habitat-loaded-mods habitat)
      (remove m (habitat-loaded-mods habitat)))))
