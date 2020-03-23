# Varnish 4 image

Varnish 4 image based on Linux Alpine. Built primarily for Magento.

# Usage

The image is constructed so that it uses in-memory storage (`malloc`).
Size of that storage is regulated through env variable `MEMORY_SIZE` which defaults to `1024M`

## Default setup

If you simply turn on the image, it will boot as `varnishd -a :80 -b 127.0.0.1:8080` meaning, use all defaults, serve on `:80`, the backend is on `localhost:8080`

## Using specific VCL

To use a custom VCL inside the image, you should either:

* Boot image with `VCL_PATH` variable specifying the path
* Mount the VCL as `/etc/varnish/conf.d/default.vcl`

# Debugging

## Which config was loaded?

If you listen to container output, it will show which config settings are used at the boot time, so you can be sure that your VCL reached the container.

## Magento specific config

Aside from that, on Magento, I suggest editing VCL manually, as Magento tends to misbehave when compiling it. So pay attention to:

* `.host` It can be a name that is resolvable, or the IP if you have a specific one.
* `.port` Magento always rewrites this to be `:8080`. However, as long as the original server does not publish `:80`, it can be `:80` here to avoid further problems.
* `.probe = { .url` Magento prefixes that with `/pub/` which is incorrect. It should just say `.url = "/health_check.php";`

## General troubleshooting

If you are receiving backend fetch failed, your health check is probably failing. Utilize `access.log` of your backend to troubleshoot that. Health check must return `200 OK` as a response code.