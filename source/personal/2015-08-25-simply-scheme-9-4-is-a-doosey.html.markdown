---
title: Simply Scheme 9.4 is a Doosey
date: 2015-08-25 23:17 UTC
tags: simply scheme, ch 9, lambda
---

### Man, I just finished this problem with simply scheme:

> 9.4 The following program doesn't work. Why not? Fix it. <br>
> (define (who sent) <br>
> &nbsp; &nbsp;  (every describe '(pete roger john keith))) <br>
> (define (describe person) <br>
>  &nbsp; &nbsp; (se person sent)) <br>
> *It's supposed to work like this:* <br>
> > (who '(sells out)) <br>
> (pete sells out roger sells out john sells out keith sells out) <br>

The key was to realize that the variable `sent` was going to cause some trouble because the procedure `describe` uses it and it's not set yet.  The chapter described lambdas and so I needed to piece together what I learned about how lambdas are in the procedures `define` and `let` to get `sent` bound before `describe` was called.

Here are some progressions to show how the lambda was exposed in the chapter.

~~~ 
// notes on Lambda
(define (square x) (* x x))

# was really

(define square (lambda (x) (* x x)))

# and let was really 

(define (roots a b c) ((lambda (discriminant)
    (se (/ (+ (– b) discriminant) (* 2 a))
        (/ (– (– b) discriminant) (* 2 a))))
(sqrt (– (* b b) (* 4 a c)))))
~~~

My solution from the problem

~~~
(define who
  (lambda (sent)
    (let ((describe (lambda (person) (se person sent))))
      (every describe '(pete roger john keith)))))
~~~

### Notes on lambda syntax/implementation and call

* Initially I thought it was: 
  * `(lambda (args) (func) (instances))`

* Then, I figured it was 
  * `((lambda (args) (func)) (instances))`

* so, 
  * `(let ((x 2)(y 3)) (* x y)) => 6`

* and is the same as, 
  * `((lambda (x y) (* x y)) 2 3) => 6`

* So these are equivalent:
  * `(let ((variable init) ...) expression expression ...)`
  * `((lambda (variable ...) expression expression ...) init ...)`

* and these are equivalent:
  * `(define (function args)(expression))`
  * `(define function (lambda (args)(expression)))`

### Notes on `every`

* (every <method> <sentence>)
