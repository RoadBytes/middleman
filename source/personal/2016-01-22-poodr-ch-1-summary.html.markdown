---
title: "POODR Ch 1 Summary"
date: 2016-01-22 11:48 UTC
tags: summary, poodr, ch 1
---

## Intro

* Examples of procedural and object oriented featuristics presented.  Procedural and OOP compared.  Objects tend to have it's own behavior and order of execution in contrast to procedural that's executed more line by line.

* This chapter will examine:
  * general discussion of OOP
  * argues case for *design*
  * overview and definition of common terms in book

## In Praise of Design

* Good design makes a program easier to work with and consequently also better as a product for the user.

* *The Problem Design Solves*: Good Design makes code open to change.
  * easy to write and easy to extend

* *Why Change is hard*: Interdependence among class makes a code base resistant to change bc changing one class requires adapting these changes in all dependent classes.

* *A Practical Definition of Design*: the code arrangement of an application.  Design reduces the cost of change.

## The Tools of Design

* principles and patterns, not a fixed set of rules.

* Design Principles

  * SOLID: Single Responsibility, Open-Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion.
  * DRY: Don't Repeat Yourself
  * LoD: Law of Demeter

  * These principles are tested and verified for the most part.
    * NASA code base, academic code studies

* *Design Patterns*

  * Gang of Four *Design Patterns* Book
    * simple solutions to various problems that make the design more flexible, modular, reusable, and understandable.
    * patterns were seen to be abused
    * POODR will prepare reader on how to appropriately apply patterns

## The Act of Design

  * still very difficult to implement and requires experience with tools (ie patterns).

* *How Design Fails*

  * In a lack of design (not required to have an app work).
  * Failure in applying design appropriately, ie over design.
  * Design that's disconnected from implementation process.
    * lack of iteration
    * implementation uninformed of problem space

* *When to Design*
  
  * NOT all upfront
    * Big Up Front Design is uninformed and creates adversarial relationships between software designers and customers.
  * Yes some upfront and through out.
    * implementation informs design

* *Judging Design*
  
  * Number of lines of code not that good.
    * bad metrics sign of bad design.
  * getting a feature out at cost of bad code implementation: *technical debt*
  * one must consider time cost vs technical debt cost to maximize value
  * *it takes experience to judge design appropriately*
  * Bad metrics strongly imply future difficulties; however, good metrics are less helpful. A design that does the wrong thing might produce great metrics but may still be costly to change.


## A Breif Into to OOP

* OOP = objects and messages

* *Procedural Languages*
  * data types and operations fixed
  * data and behavior are separate
  
* *OO Languages*
  * object combines data and behavior

## Summary

* Design helps minimize the cost of change
* Good design requires practice
