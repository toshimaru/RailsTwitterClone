## [Will Paginate][wp] link renderer styles for [Twitter Bootstrap 4][bs4] and [Twitter Bootstrap 5][bs]

![ex](https://user-images.githubusercontent.com/2103263/117255171-01761800-ae52-11eb-9950-cf9e22772325.png)

Rails Engine that extends [will_paginate][wp] stylings to match the pagination styling conventions
in Twitter's [Bootstrap][bs] toolkit.

### Installation

Add to your Gemfile:  

    gem 'will_paginate-bootstrap-style'

### Usage

Just like you would in the regular [will_paginate][wp].  If you've got a need to use the default will_paginate stylings,
pass an option like so:

    <%= will_paginate @collection, renderer: WillPaginate::ActionView::BootstrapLinkRenderer %>

The following options are available (in addition to the options available in will_paginate):

    :list_classes = ['pagination']    # Array of classes
    :aria_label = 'Page Navigation'   # The aria label to use in the Nav tag
    :previous_label = '&laquo;'       # Previous page label
    :next_label = '&raquo;'           # Next page label

For example, to place the navigation section to the far right of the page, use this in your view:

    <%= will_paginate @clients, list_classes: %w(pagination justify-content-end) %>

[wp]: http://github.com/mislav/will_paginate
[bs]: http://getbootstrap.com/
[bs4]: http://getbootstrap.com/docs/4.0/
