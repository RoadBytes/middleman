---
title: "Tea Leaf Course 3 week 5"
date: 2015-12-06 23:06 UTC
tags: tealeaf, redis, background jobs, sidekiq
---

Tea Leaf Academy Course 3 Lesson 5 Part 2

## Learning about background jobs

[resque brief history](https://github.com/blog/542-introducing-resque)

Resque is a Redis-backed library for creating background jobs

Here's that list of what was desired from a background job app:

* Persistence
* See what's pending
* Modify pending jobs in-place
* Tags
* Priorities
* Fast pushing and popping
* See what workers are doing
* See what workers have done
* See failed jobs
* Kill fat workers
* Kill stale workers
* Kill workers that are running too long
* Keep Rails loaded / persistent workers
* Distributed workers (run them on multiple machines)
* Workers can watch multiple (or all) tags
* Don't retry failed jobs
* Don't "release" failed jobs

[sidekiq docs](https://github.com/mperham/sidekiq)

## Staging

* notes from TeaLeaf

> A few things I'd like to add:
> 
> 1) Make staging server's configuration and data as close to the production server as possible - after all, the purpose of having the staging server is to be able to test out new features in a "production like" environment.
> 
> If your production app is already launched, you can periodically take database dumps from the production server to populate the staging server. You could automate this as well with either a replication service, or if you are on Heroku, use Heroku's follower DB (comes with a cost) https://devcenter.heroku.com/articles/heroku-postgres-follower-databases
> 
> 2) You want to be mindful on email sending on staging - staging server will actually send out emails. You want to make sure that you do not spam your users while testing out features on the staging server. This can be achieved by adding a conditional in your mailer to see if the environment is staging, and if it is, set email recipients to administrators (such as yourself). This way, you can still test and verify that emails are sent out, but you don't spam users.
> 
> 3) Your staging server can (and typically should) have a different config itself - you just need to create a staging.rb file in config/environments directory, and with it you can specify the exact settings you want on there (for example, turning on asset pipeline or not, sending out email or not, charging credit card for real or not, etc). On your Heroku staging server, make sure to set RACK_ENV and RAILS_ENV to staging, then it'll use that config instead. For Heroku specifically, you also need to add the rails_12factor gem to the staging environment for the asset pipeline to work on Heroku.

* notes from [heroku site](https://devcenter.heroku.com/articles/multiple-environments)

## Understand and set up a simple deployment pipeline

[Article to read from Martin Fowler](http://martinfowler.com/bliki/DeploymentPipeline.html)

In summary, our simple deployment pipeline process is run entire test suite locally -> deploy to staging and test -> deploy to production. This is probably good enough for solo developers or small teams. We'll talk about Continuous Integration and Continuous Deployment with more automation in the next several topics.

## Continuous Integration

[An article on CI by Fowler](http://martinfowler.com/articles/continuousIntegration.html)

> Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day.

## Continuous Delivery

From TeaLeaf Assignment

> * we pull the latest code from Github
> * we create a new feature branch and develop a new feature
> * after we finish the feature, we push it to a branch with the same name on Github
> * we create a PR from this branch to the staging branch.
> * we wait for the the CI server to ensure all tests pass.
> * we allow the CI server to automatically deploy the code from the staging branch to our staging server
> * we perform sanity tests on our staging server
> * we create a PR from the staging branch to the master branch on Github
> * this will trigger another round of integration and if it passes, the CI server will automatically deploy the code to the production server.
