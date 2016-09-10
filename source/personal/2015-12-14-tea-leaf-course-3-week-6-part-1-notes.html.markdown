---
title: "Tea Leaf Course 3 Week 6 part 2 notes"
date: 2015-12-14 02:43 UTC
tags: tealeaf, actors, roles, aws, carrierwave
---

Tea Leaf Academy Course 3 Lesson 6 Part 2

* This part of the lesson involves adding new videos for Admin actors (Admin roles were from lesson 6 part 1)
  + It's involved with AWS S3 accounts and carrierwave for file upload.

## Adding Admin New Video Feature

Notes from the lesson:

* *Important Update for Amazon S3:* Amazon has since added an extra step that you need to now add permissions by attaching a user policy to a user. You can follow it here:

Article on: *Createing a simple aws s3 bucket with iam access control*

http://blog.danielle.tuckerlabs.com/post/60491757671/creating-a-simple-aws-s3-bucket-with-iam-access

* `iam` identifies a user or an application and whitelists what services are accessible to him/her/it.  Specifically, I'd only use it to allow the app to upload pictures, and NOT changes routes for example.

* what is an s3 bucket?

> A bucket is a logical unit of storage in Amazon Web Services (AWS) object storage service, Simple Storage Solution S3. Buckets are used to store objects, which consist of data and metadata that describes the data.

adding user policy to bucket:

~~~
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "NotAction": "iam:*",
      "Resource": "*"
    }
  ]
}
~~~

Article on: *Amazon s3 buckets described in plain english*

http://www.labnol.org/internet/tools/amazon-s3-buckets-tutorial/3890/

I had to install `carrier-aws` for staging and production

use `carrierwave-aws` found here: https://github.com/sorentwo/carrierwave-aws

Setting up the config file:

ImageMagick was also installed on my local machine:

http://stackoverflow.com/questions/7053996/how-do-i-install-imagemagick-with-homebrew

Making sure to manage privileged info:

https://launchschool.com/blog/managing-environment-configuration-variables-in-rails

### New Gems!

for handling s3 and file management
gem 'carrierwave-aws'

for processing image
gem 'mini_magick'

### Feature Spec

* adding file features to testing
  + add files to `spec/support/uploads/`
    `attach_file 'spec/support/uploads/file'`

