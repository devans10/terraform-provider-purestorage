---
title: "Provider"
date: 2019-03-22T20:49:09-04:00
lastmod: 2019-05-07T09:33:09-04:00
draft: false
description: ""
weight: 2
---

The provider is used to interact with the resources supported by the Pure Storage FlashArray.  The provider needs to be configured with the proper credentials before it can be used.

## Example Usage

```sh
# Set the variable values in *.tfvars file
# of using -var="purestorage_target=..." CLI option
variable "purestorage_target" {}
variable "purestorage_apitoken" {}

# Configure the Pure Storage Provider
provider "purestorage" {
  target = "${var.purestorage_target}"
  api_token = "${var.purestorage_apitoken}"
}

resource "purestorage_volume" "vol" {
  # ...
}
```

## Argument Reference

The following arguments are supported:

+ `target` - (Optional) This is the FQDN or IP Address of the target array.
+ `api_token` - (Optional) The API Token used to connect to the array.
+ `username` - (Optional) The username to connect to the array.
+ `password` - (Optional) The password used to connect to the array. Required if username specified.

*Note: Either `api_token` or `username` and `password` can be specified, but not both.*

Optionally, the provider can be configured using environment variables `PURE_TARGET`, `PURE_APITOKEN`, `PURE_USERNAME`, and `PURE_PASSWORD`
