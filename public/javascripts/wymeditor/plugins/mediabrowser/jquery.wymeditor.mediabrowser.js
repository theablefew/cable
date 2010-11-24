(function($, undefined) {
    function MediaBrowser (options, wym) {
        var self = this;
        
        this.options = $.extend(true, {}, this.defaults, options); 
        
        this.element = $('<div id="' + this.options.dialogClass + '-' + new Date().getTime() + '" class="' + this.options.dialogClass + '"></div>')
            .hide()
            .appendTo(document.body)
            .dialog(this.options.dialog)
            .bind('dialogclose', $.proxy(this, 'onClose'))
            .data('mediaBrowser', this);
        
        this.wym = wym;
        
        if (this.options.onInit) {
            this.options.onInit();
        }
    };
    
    MediaBrowser.prototype = {
        defaults: {
            dialogClass: 'media-browser',
            contentSelector: 'img',
            contentEvent: 'dblclick',
            reloadOnOpen: true,
            url: '/admin/photos/wym',
            dialog: {
                title: 'Media Browser',
                autoOpen: false,
                width: 900,
                height: 700,
                modal: true
            },
            onInit: null,
            onLoad: null
        },
        
        open: function (targetElement) {
            this.targetElement = targetElement = (targetElement && targetElement[0]) || targetElement;

            this.element.dialog('open');
            
            if (this.options.reloadOnOpen || !this.element[0].children.length) {
                this.element.load(this.options.url, $.proxy(this, 'onLoad'));
            } else {
                this.onLoad();
            }
        },
        
        onLoad: function () {
            if (this.options.onLoad) {
                this.options.onLoad();
            }
        },
        
        onClose: function () {
            this.element.removeData('targetElement');
            this.targetElement = null;
        },
        
        insert: function (html, place) {
            var container = $(this.wym.selected(), this.wym._doc);
                targetElement = (place && typeof place === 'object') ? 
                    place : this.targetElement;
            
            switch (place) {
                case 'prepend':
                    container.prepend(html);
                break;
                case 'append':
                    container.append(html);
                break;
                default: // replace
                    if (targetElement) {
                        $(targetElement, this.wym._doc).replaceWith(html);
                    } else {
                        this.wym.insert(html);
                    }
            }
        }
    };

    // Extend WYMeditor
    WYMeditor.editor.prototype.initMediaBrowser = function(options) {
        var browser = new MediaBrowser(options, this),
            wym = this;

        // Construct the button's html
        var html = "<li class='wym_tools_media'>"
            + "<a name='Media browser' href='#'"
            + " style='background-image:"
            + " url(" + wym._options.basePath +"plugins/mediabrowser/browser.png)'>"
            + "Meda browser"
            + "</a></li>",

        // Add the button to the tools box
            li = $(html).appendTo(
                    $(wym._box).find(wym._options.toolsSelector 
                                    + wym._options.toolsListSelector));

        // Handle button click event
        li.children('a').bind('click', function() {
            browser.open(wym._selected_image);
        });
        
        // Handle events inside the editor
        $(wym._doc).bind(browser.options.contentEvent, function (event) {
            var target = $(event.target);
            if (target.is(browser.options.contentSelector)) {
                browser.open(target);
            }
        });
    }; 
})(jQuery)
