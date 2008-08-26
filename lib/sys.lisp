;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CLPYTHON.MODULE.SYS -*-
;;
;; This software is Copyright (c) Franz Inc. and Willem Broekema.
;; Franz Inc. and Willem Broekema grant you the rights to
;; distribute and use this software as governed by the terms
;; of the Lisp Lesser GNU Public License
;; (http://opensource.franz.com/preamble.html),
;; known as the LLGPL.

(in-package :clpython.module.sys)

(defvar |argv| :todo "Comand line args passed to script; argv[0] is script name (rel or abs)")
(set-impl-status '|argv| :todo)

(defvar |byteorder| :n/a "Byte order of implementation: 'big' or 'little'")
(set-impl-status '|byteorder| :n/a "Byte order is hidden in Lisp implementation.")

;; Not implemented, and no intention to: 
;;  subversion, _current_frames, dllhandle, exc_type, exc_value, exc_traceback,
;;  getrefcount, _getframe, settscdump, winver
;;
;; Not implemented, but perhaps later:
;;  exc_info, exc_clear, exec_prefix, executable, getwindowsversion,
;;  last_{type,value,traceback}, {g,s}etdlopenflags, setprofile, settrace,
;;  tracebacklimit, warnoptions

(defun |exc_info| ()
  (declare (special *try-except-currently-handled-exception*))
  (clpython::make-tuple-from-list 
   (if *try-except-currently-handled-exception*
       (list (clpython::py-class-of *try-except-currently-handled-exception*)
	     *try-except-currently-handled-exception*
	     *the-none*) ;; traceback object
     (list *the-none* *the-none* *the-none*))))
(set-impl-status '|exc_info| :incomplete "No traceback objects (yet).")

(defvar |copyright| "Copyright (c) Franz Inc. and Willem Broekema.")
(set-impl-status '|copyright| t)

(defvar |builtin_module_names| *the-empty-tuple*
  #+(or)(clpython::make-tuple-from-list
	 (loop for hk being the hash-value in clpython::*builtin-modules*
	     collect (string (clpython::py-module-name hk)))))
(set-impl-status '|builtin_module_names| :incomplete "Currently always return empty list.")

(defvar |displayhook| *the-none*
  "Func of one arg, called by REPL to print val")
(set-impl-status '|displayhook| :todo "Currently not called by REPL.")

(defvar |excepthook| *the-none*
  "Function to be called on uncatched exception, e.g.to print stack trace")
(set-impl-status '|excepthook| :todo "Currently never called.")

(defvar |__displayhook__| *the-none*
  "Original value of displayhook")
(set-impl-status '|__displayhook__| t)

(defvar |__excepthook__| *the-none*
  "Original value of excepthook")
(set-impl-status '|__excepthook__| t)

(defun |exit| (&optional arg)
  (py-raise '{SystemExit} "sys.exit(~@[~A~]) called" arg))
(set-impl-status '|exit| t)

(defvar |exitfunc| *the-none*
  "Function to be called upon exit")
(set-impl-status '|exitfunc| :todo "Currently never called.")


(defun |setcheckinterval| (arg)
  "How often to check for thread switches and signal handlers"
  (declare (ignore arg))
  :n/a)
(set-impl-status '|setcheckinterval| :n/a "Based on byte code implementation.")

(defun |getcheckinterval| ()
  "How often to check for thread switches and signal handlers"
  :n/a)
(set-impl-status '|getcheckinterval| :n/a "Based on byte code implementation.")

(defun |getdefaultencoding| ()
  :todo)
(set-impl-status '|getdefaultencoding| :todo)

(defun |setdefaultencoding| (val)
  (declare (ignore val)) 
  :todo)
(set-impl-status '|setdefaultencoding| :todo)

(defun |getfilesystemencoding| () 
  :todo)
(set-impl-status '|getfilesystemencoding| :todo)

(let ((rec-limit 42))
  (defun |getrecursionlimit| ()    rec-limit)
  (defun |setrecursionlimit| (val) (setf rec-limit val))
  
  (set-impl-status '(|getrecursionlimit| |setrecursionlimit|)
		   :todo "Currently not taken into account."))

(defvar |hexversion| :todo)
(set-impl-status '|hexversion| :todo)

(defvar |maxint| most-positive-fixnum
	"Largest positive integer represented by regular integer type")
(set-impl-status '|maxint| t "Set to `most-positive-fixnum'.")

(defvar |maxunicode| char-code-limit
  "Largest supported unicode code point")
(set-impl-status '|maxunicode| t "Set to `char-code-limit'.")

(defvar |modules| "todo"
  "Mapping from module names (strings) to modules")
(set-impl-status '|modules| :todo)
  
;; List of search paths
(defvar |path| (clpython::make-py-list-from-list (list "."))
  "List of directories to search for module to import")
(set-impl-status '|path| t "only directories supported (not zip files etc).")

(defvar |platform| "Common Lisp")
(set-impl-status '|platform| t "Set to `Common Lisp'.")

(defvar |prefix| *the-none*
  "Site-specific directory prefix for installing platform independent Python files")
(set-impl-status '|prefix| :todo "Automatically installing modules is not supported yet.")

;; REPL input prefixes
;; XXX do str() on non-string value! http://effbot.org/pyref/sys.ps1.htm
(defvar |ps1| ">>> " "First interpreter prompt")
(defvar |ps2| "... " "Second interpreter prompt")

(set-impl-status '(|ps1| |ps2|) :todo "Not consulted by REPL yet.")

(defvar |stdin|  :todo "Standard input")
(defvar |stdout| :todo "Standard output")
(defvar |stderr| :todo "Standard error output")

(set-impl-status '(|stdin| |stdout| |stderr|) :todo "Not consulted yet.")

(defvar |__stdin__|  :todo "Initial stdin")
(defvar |__stdout__| :todo "Initial stdout")
(defvar |__stderr__| :todo "Initial stderr")

(set-impl-status '(|__stdin__| |__stdout__| |__stderr__|) :todo "Not set yet.")

(defvar |api_version| :todo "The (Lisp) API version")
(set-impl-status '|api_version| :todo "The CLPython Lisp API has no version number yet.")

(defvar |version_info| :filled-later "Tuple like (2, 0, 0, 'final', 0)")
(defvar |version|      :filled-later "String like '1.5.2 (#0 Apr 13 1999, 10:51:12) [MSC 32 bit (Intel)]'")

(let ((py-version (clpython::make-tuple-from-list '(2 5 0 "alpha" 0)))) 
  ;; XXX figure out which we resemble
  (setf |version_info| py-version)
  (setf |version|      (format nil "CLPython 2.5.0 alpha (~A ~A)"
				 (lisp-implementation-type) (lisp-implementation-version)))

  (set-impl-status '|version_info| t (format nil "Set to `~A'" |version_info|))
  (set-impl-status '|version| t (format nil "Set to `~A'" |version|)))
