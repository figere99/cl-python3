CLPython - an implementation of Python in Common Lisp
=====================================================

WIP PYTHON 3 FORK

CLPython is an open-source implementation of Python written in Common Lisp.
With CLPython you can run Python programs in a Lisp environment. Libraries written
in Lisp are available to Python code, and Python libraries can be accessed by Lisp code.
Also Python and Lisp code can be mixed.

For rough documentation, please see the [Introduction](http://common-lisp.net/project/clpython/index.html) and
[Manual](http://common-lisp.net/project/clpython/manual.html) on *common-lisp.net*.

Work on this fork has barely been started so it is not in QuickLisp or Ultralisp yet.

CLPython is developed by Willem Broekema and is released as open source under the [LLGPL](http://opensource.franz.com/preamble.html).
The project was started in 2006, and is since 2013 not under active development anymore.
This fork is an attempt by figere99 at porting CLPython to Python 3 while touching it up along the way.

See the [build status](https://travis-ci.org/metawilm/cl-python) on Travis-CI, and the [coverage status](https://coveralls.io/github/metawilm/cl-python?branch=master) on Coveralls:

| Common Lisp Implementation | Build + Test Status | |
|:-:|:-:|:-:|
| [ABCL](https://common-lisp.net/project/armedbear/) 1.5.0 | [![Build Status](https://travis-build-job-badge.herokuapp.com/badge?user=metawilm&repo=cl-python&branch=master&envContains=abcl+CATCH&label=ABCL)](https://travis-ci.org/metawilm/cl-python) | Fails due to `ClassCastException: StandardObject cannot be cast to LispClass` |
| [Allegro CL](http://franz.com/products/allegrocl/) 10.1 | [![Build Status](https://travis-build-job-badge.herokuapp.com/badge?user=metawilm&repo=cl-python&branch=master&envContains=allegro+CATCH&label=Allegro+CL)](https://travis-ci.org/metawilm/cl-python) | |
| [Clozure CL](http://clozure.com/clozurecl.html) 1.11 | [![Build Status](https://travis-build-job-badge.herokuapp.com/badge?user=metawilm&repo=cl-python&branch=master&envContains=ccl&label=Clozure+CL)](https://travis-ci.org/metawilm/cl-python) | |
| [CLISP](http://clisp.sourceforge.net) 2.49         | [![Build Status](https://travis-build-job-badge.herokuapp.com/badge?user=metawilm&repo=cl-python&branch=master&envContains=clisp&label=CLISP)](https://travis-ci.org/metawilm/cl-python) | Fails due to stack overflow |
| [CMUCL](http://www.cons.org/cmucl/)                | ? | |
| [ECL](http://ecls.sourceforge.net/) 16.1.3         | [![Build Status](https://travis-build-job-badge.herokuapp.com/badge?user=metawilm&repo=cl-python&branch=master&envContains=ecl+CATCH&label=ECL)](https://travis-ci.org/metawilm/cl-python) | |
| [LispWorks](http://www.lispworks.com/) 6.1.1       | ✅ | Manually verified |
| [SBCL](http://sbcl.sourceforge.net/) 1.5.4         | [![Build Status](https://travis-build-job-badge.herokuapp.com/badge?user=metawilm&repo=cl-python&branch=master&envContains=sbcl&label=SBCL)](https://travis-ci.org/metawilm/cl-python) [![Coverage Status](https://coveralls.io/repos/metawilm/cl-python/badge.svg?branch=master)](https://coveralls.io/r/metawilm/cl-python?branch=master) | |
