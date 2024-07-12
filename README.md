# proxmoxutils
a toolbox for admin tasks around proxmox


## remove 'No valid subscription' popup

After logging in to proxmox on a self-hosted instance without active subscription a message 'No valid subscription' pops up. 
This can be annoying.

Responsible is the function *checked_command()* in the javascript file */usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js*.

The fix is simple: Skip the API request by calling the orig_cmd() function and returning.

```javascript
checked_command: function(orig_cmd) {
    orig_cmd();return;
    Proxmox.Utils.API2Request(
        url: '/nodes/localhost/subscription',
        method: 'GET',
        ...
    );
}
```
See *remove_subscription_notice.sh* bash script for details how to do it.
