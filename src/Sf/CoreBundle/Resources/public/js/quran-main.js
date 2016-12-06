//////////////////////////////////////////////////
// Navigational Menu ddsmoothmenu
$(document).ready(function () {

    ddsmoothmenu.init({
        mainmenuid:"menu", //menu DIV id
        orientation:'h', //Horizontal or vertical menu: Set to "h" or "v"
        classname:'navigation', //class added to menu's outer DIV
        //customtheme: ["#1c5a80", "#18374a"],
        contentsource:"markup" //"markup" or ["container_id", "path_to_menu_file"]
    })


})

// add js class to html tag
$('html').addClass('js');

// Responsive Navigation Menu by SelectNav
jQuery(document).ready(function () {
    selectnav('nav', {
        label:'- Navigation Menu - ',
        nested:true,
        indent:'-'
    });
});

// UItoTop plugin 
$(document).ready(function () {
    $().UItoTop({ easingType:'easeOutQuart' });
});

// Alert Boxes
$(document).ready(function () {
// Closing notifications
// this is the class that we will target
    $(".hideit").click(function () {
//fades the notification out
        $(this).fadeOut(600);
    });
});

/*
 * Playlist
 * */
$(document).ready(function () {

    $(".save-playlist").click(function () {
        var _name = $(this).attr("title-trans");
        var _ok = $(this).attr("ok-trans");
        var _cancel = $(this).attr("cancel-trans");
        apprise(_name, {'input':true, 'textOk':_ok, 'textCancel':_cancel}, savePlayList);
    });

    $('.cancel-playlist,.cancel-playlist-btn').click(function () {
        $('#playlist-ul').html('');
        $('.save-playlist').fadeOut();
        $('.cancel-playlist').fadeOut();
    });

    $(".playlist-delete").click(function () {
        var _delete_title = $(this).attr("title-trans");
        var _yes = $(this).attr("yes-trans");
        var _cancel = $(this).attr("cancel-trans");
        var _id = $(this).attr("id");
        apprise(_delete_title, {'verify':true, 'textYes':_yes, 'textNo':_cancel, 'id_element':_id}, deletePlayList);
    });

    deleteItemHandler();

    $(".edit-playlist-btn").click(function () {
        var _name = $(this).attr("title-trans");
        var _ok = $(this).attr("ok-trans");
        var _cancel = $(this).attr("cancel-trans");
        var _playlistName = $('#playlist-name').val();
        apprise(_name, {'input':_playlistName, 'textOk':_ok, 'textCancel':_cancel}, editPlayList);
    });

    /*
     * Tabs
     * */
    var _tabsLi = $('#horizontal-tabs').find('li');
    _tabsLi.click(function () {
        var _this = $(this);
        var _url = _this.attr('data-link');
        _this.addClass('current');
        _this.siblings().removeClass('current');
        $("#loader-img").show();
        $('.tabscontent').html('');
        getPage(_url);
        return false;
    });
    _tabsLi.eq(0).trigger('click');
});

function getPage(_url) {
    var _ContentTab = $('.tabscontent');
    $.ajax({
        url:_url,
        type:"GET",
        cache:false,
        success:function (html) {
            $("#loader-img").hide();
            _ContentTab.html(html);
            playListAccordion();
            _ContentTab.fadeIn('slow');
        }
    });
}

function setPlayerOn() {
    $("#total-playlist").totalControl({
        style:"light.css",
        checkboxesEnabled:true,
        playlistSortable:true,
        position:"relative",
        playlistHeight:170,
        repeatOneEnabled:true,
        repeatAllEnabled:true,
        shuffleEnabled:true,
        playlistVisible:true,
        songTooltipPosition:"top",
        songTooltipEnabled:false,
        miniPlayer:false,
        isDraggable:false,
        autoplayEnabled:false,
        addSongEnabled:false

    });

    /**
     * Home Player
     */

    $("#total-playlist-home").totalControl({
        style:"light.css",
        checkboxesEnabled: true,
        playlistSortable: true,
        position: "relative",
        playlistHeight:100,
        repeatOneEnabled: true,
        repeatAllEnabled: true,
        shuffleEnabled: true,
        playlistVisible: true,
        songTooltipPosition: "top",
        songTooltipEnabled: false,
        miniPlayer:false,
        isDraggable: false,
        autoplayEnabled: false,
        addSongEnabled: false

    });
}

function playListAccordion() {
    $(".accordion").accordion({
        autoHeight:false,
        active:false,
        collapsible:true,
        icons:{ "header":"plus", "headerSelected":"minus" }
    });
    $(".reciter-accordion a").click(function () {
        showChapterList($(this));
    });
    $(".reciter-accordion span").click(function () {
        showChapterList($(this));
    });
    playListAction();
}

function showChapterList(_this) {
    $('div.accordion-contain').each(function () {
        $(this).html('');
    });
    var _chapterList = $('#chapter-hidden-list');
    var _div = _this.parent().next('div.accordion-contain');
    _div.html(_chapterList.html());
    playListAction();
}
function playListAction() {

    $("a.animated-hover").hover(function () {
        $(this).stop().animate({ opacity:0.75 }, 100);
    }, function () {
        $(this).stop().animate({ opacity:1 }, 100);
    });

    $(".chapter-playlist li").hover(function () {
        $(this).stop().animate({ opacity:0.75 }, 100);
    }, function () {
        $(this).stop().animate({ opacity:1 }, 100);
    });

    $(".chapter-playlist li span.chapter").click(function () {

        var _this = $(this);
        var _dataType = $(this).attr('data-type');

        var _cpH = $("<li />");
        var _cp = _this.clone();

        if (_dataType == "chapter") {
            var _chapterId = $(this).attr('chapter-id');
            var _reciterId = $(this).parents('div').attr('reciter-id');
            var _id = "chapterId_playlist_" + _chapterId;
            var _reciterName = $("#reciter_name_" + _reciterId).html();
            _cp.attr({'id':_id});
            _cp.attr({'data-type':_dataType});
            _cp.attr({'reciter-id':_reciterId});
            _cp.append(" (" + _reciterName + ")");
            _cpH.append($("<img />").attr({'class':'playlist-delete-item', 'src':'/bundles/core/images/delete.png'}));
            _cpH.append(_cp);
            _cpH.appendTo('#playlist-ul');

        } else if (_dataType == "adhkar") {
            var _adhkarId = $(this).attr('adhkar-id');
            var _id = "adhkar_playlist_" + _adhkarId;
            _cp.attr({'id':_id});
            _cp.attr({'data-type':_dataType});
            _cpH.append($("<img />").attr({'class':'playlist-delete-item', 'src':'/bundles/core/images/delete.png'}));
            _cpH.append(_cp);
            _cpH.appendTo('#playlist-ul');
        } else if (_dataType == "tilawa") {
            var _tilawaId = $(this).attr('tilawa-id');

            var _id = "tilawa_playlist_" + _tilawaId;
            _cp.attr({'id':_id});
            _cp.attr({'data-type':_dataType});
            _cpH.append($("<img />").attr({'class':'playlist-delete-item', 'src':'/bundles/core/images/delete.png'}));
            _cpH.append(_cp);
            _cpH.appendTo('#playlist-ul');

        }

        _this.animate({ opacity:0 }, 500);
        _this.animate({ opacity:1 }, 500);
        _cp.animate({ opacity:0 }, 500);
        _cp.animate({ opacity:1 }, 500);

        if ($("#playlist-ul li").length > 0) {
            $('.save-playlist').fadeIn();
            $('.cancel-playlist').fadeIn();
        }
        deleteItemHandler();
        return false;
    });
}

function deleteItemHandler() {
    $(".playlist-delete-item").click(function () {
        var _parent = $(this).parent();
        _parent.fadeOut(300, function () {
            $(this).remove();
        });
    });
}

function deletePlayList(_confrim,id_element) {
    if (_confrim) {
        var _this = $("#"+id_element);
        var _url = _this.attr("delete-url");
        $("#loader-img").show();

        $.ajax({
            type:"GET",
            url:_url,
            success:function (response) {
                $("#loader-img").hide();
                if (response != '') {
                    window.location.href = response;
                }
            }
        });
    }
}

function editPlayList(_name) {
    if (_name) {
        var _this = $(".edit-playlist-btn");
        var _url = _this.attr("save-url");
        $("#loader-img").show();
        sendPlayListData(_name, _url)
    }
}
function savePlayList(_name) {
    if (_name) {
        var _this = $(".save-playlist");
        var _url = _this.attr("save-url");
        $("#loader-img").show();
        sendPlayListData(_name, _url)
    }
}

function sendPlayListData(_name, _url) {
    var _items = [];
    var cp = 0;
    $("#playlist-ul").find("li span.chapter").each(function () {
        var _thisItem = $(this);
        var _dataType = _thisItem.attr("data-type");
        _items[cp] = [];
        if (_dataType == "chapter") {
            _items[cp][0] = _thisItem.attr("reciter-id");
            _items[cp][1] = _thisItem.attr("chapter-id");
        } else if (_dataType == "adhkar") {
            _items[cp][0] = _thisItem.attr("adhkar-id");
            _items[cp][1] = null;
        }
        else if (_dataType == "tilawa") {
            _items[cp][0] = _thisItem.attr("tilawa-id");
            _items[cp][1] = null;
        }
        _items[cp][2] = _dataType;
        cp++;
    });

    $.ajax({
        type:"POST",
        url:_url,
        data:{ data:_items, name:_name},
        success:function (response) {
            $("#loader-img").hide();
            if (response != '') {
                window.location.href = response;
            }
        }
    });
}

// Isotope Filtering
$(function () {

    var $container = $('#contain');

// initialize Isotope
    $container.isotope({
        // options...
        resizable:false, // disable normal resizing
        // set columnWidth to a percentage of container width
        masonry:{ columnWidth:$container.width() / 12 }
    });

    // update columnWidth on window resize
    $(window).smartresize(function () {
        $container.isotope({
            // update columnWidth to a percentage of container width
            masonry:{ columnWidth:$container.width() / 12 }
        });
    });


    $container.isotope({
        itemSelector:'.item',
        animationOptions:{
            duration:750,
            easing:'linear',
            queue:true
        }
    });


    var $optionSets = $('#options .option-set'),
        $optionLinks = $optionSets.find('a');

    $optionLinks.click(function () {
        var $this = $(this);
        // don't proceed if already selected
        if ($this.hasClass('selected')) {
            return false;
        }
        var $optionSet = $this.parents('.option-set');
        $optionSet.find('.selected').removeClass('selected');
        $this.addClass('selected');

        // make option object dynamically, i.e. { filter: '.my-filter-class' }
        var options = {},
            key = $optionSet.attr('data-option-key'),
            value = $this.attr('data-option-value');
        // parse 'false' as false boolean
        value = value === 'false' ? false : value;
        options[ key ] = value;
        if (key === 'layoutMode' && typeof changeLayoutMode === 'function') {
            // changes in layout modes need extra logic
            changeLayoutMode($this, options)
        } else {
            // otherwise, apply new options
            $container.isotope(options);
        }

        return false;
    });


});

function jump(menu) {
    ref = menu.choice.options[menu.choice.selectedIndex].value;
    splitc = ref.lastIndexOf("*");
    target = "";
    if (splitc != -1) {
        loc = ref.substring(0, splitc);
        target = ref.substring(splitc + 1, 1000);
    }
    else {
        loc = ref;
        target = "_self";
    }
    ;
    if (ref != "") {
        land(loc, target);
    }
}
function land(ref, target) {
    lowtarget = target.toLowerCase();
    if (lowtarget == "_self") {
        window.location = loc;
    }
    else {
        if (lowtarget == "_top") {
            top.location = loc;
        }
        else {
            if (lowtarget == "_blank") {
                window.open(loc);
            }
            else {
                if (lowtarget == "_parent") {
                    parent.location = loc;
                }
                else {
                    parent.frames[target].location = loc;
                }
                ;
            }
        }
    }
}