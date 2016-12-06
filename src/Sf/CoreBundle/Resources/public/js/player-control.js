// Total Control HTML5 Audio Player v1.0
// by George Holmes II

soundManager.url = '/bundles/core/swf';

(function ($) {
    $.fn.totalControl = function (options) {

        function supports_ogg_audio() {
            var a = document.createElement('audio');
            return !!(a.canPlayType && a.canPlayType('audio/ogg; codecs="vorbis"').replace(/no/, ''));
        }

        function supports_mp3_audio() {
            var a = document.createElement('audio');
            return !!(a.canPlayType && a.canPlayType('audio/mpeg;').replace(/no/, ''));
        }

        var supportOgg = supports_ogg_audio();
        var supportMp3 = supports_mp3_audio();
        var browser = ""
        if (navigator.userAgent.indexOf("Safari") > -1 && navigator.userAgent.indexOf("Chrome") < 1) {
            browser = "Safari";
        }
        // Set default options
        var options = $.extend({
            style:'default.css',
            position:'relative',
            shuffleEnabled:true,
            repeatOneEnabled:true,
            repeatAllEnabled:true,
            playlistVisible:true,
            autoplayEnabled:false,
            playlistHeight:165,
            playlistSortable:true,
            checkboxesEnabled:true,
            songTooltipEnabled:true,
            songTooltipPosition:"bottom",
            miniPlayer:true,
            isDraggable:false,
            addSongEnabled:false

        }, options);

        return this.each(function () {
            var thisPlayer = $(this);
            thisPlayer.attr("class", "total-control-player");
            $('head').append('<link rel="stylesheet" href="/bundles/core/css/player/' + options.style + '" type="text/css" />');
            var playerHtml = '';
            var totalSongs = 0;
            var useFlash = "no";
            thisPlayer.find("li").each(function () {
                var thisTitle = $(this).attr("title");
                var thisArtist = $(this).attr("artist");
                var thisMp3 = $(this).attr("mp3");
                var thisOgg = $(this).attr("ogg");
                var thisSrc = "";
                var thisArtwork = $(this).attr("artwork");
                /*
                 * Sadok
                 * */
                supportOgg = false;

                if (thisArtwork) {
                    var artwork = "artwork='" + thisArtwork + "'";
                }
                else {
                    var artwork = "";
                }
                // Attach mp3 file if browser supports mp3 and mp3 file has been specified
                if (supportMp3) {
                    if (thisMp3)
                        thisSrc = thisMp3;
                }

                // Attach ogg file if browser supports ogg and ogg file has been specified (plugin prioritizes ogg over mp3)
                if (supportOgg && browser != "Safari") {
                    if (thisOgg)
                        thisSrc = thisOgg;
                }

                if (!supportOgg && !supportMp3) {
                    if (thisMp3)
                        thisSrc = thisMp3;

                    useFlash = "yes";

                    thisPlayer.find(".total-volume-slider").slider({
                        range:"max",
                        min:0,
                        max:100,
                        value:50,
                        slide:function (event, ui) {

                        }
                    });

                }
                else {
                    thisPlayer.find(".total-volume-slider").slider({
                        range:"max",
                        min:0,
                        max:1,
                        value:0.5,
                        step:0.01,
                        slide:function (event, ui) {

                        }
                    });
                }

                // Set artist and title as unknown if they aren't specified
                if (!thisArtist)
                    thisArtist = " ";
                if (!thisTitle)
                    thisTitle = " ";

                // If supported filetype isn't specified ignore playlist row
                if (!thisSrc) {
                    playerHtml += "";
                }
                else
                // Set markup of playlist row
                {
                    playerHtml += "<div onClick='' class='total-row can-play' " + artwork + ">" +
                        "<div type='checkbox' onClick='' class='total-checked'></div>" +
                        "<div class='total-not-playing'></div>" +
                        "<div class='total-title' src='" + thisSrc + "'>" + thisTitle + "</div>" +
                        "<div class='total-artist'>" + thisArtist + "</div><div style='clear:both;'></div>" +
                        "</div>";
                    totalSongs++;
                }

            });// End traversing playlist rows

            // Get artist and title of first song
            var firstTitle = thisPlayer.find("li:first").attr("title");
            var firstArtist = thisPlayer.find("li:first").attr("artist");

            ///////////////////////////////////////////////////////////////

            // Display markup for this Total Control player
            if (options.miniPlayer == true && options.position == "relative") {
                thisPlayer.html("<div class='total-control-panel'>" +
                    "<div class='total-volume-slider' style='display:none;'></div><div class='total-lcd-screen'>" +
                    "<div class='total-playing-title'>" + firstTitle + "</div>" +
//                    "<div class='total-playing-artist'>" + firstArtist + "</div>" +
                    "<div class='total-song-position'>0:00</div>" +
                    "<div class='total-song-duration'>0:00</div></div>" +
                    "<div class='total-position-scrubber'></div>" +
                    "<div class='total-play'></div><div class='total-next'></div>" +
                    "<div class='total-previous'></div>" +
                    "</div><div class='total-song-tooltip'><div class='total-artwork'></div>" +
                    "<div class='total-tooltip-title'>" + firstTitle + "</div>" +
                    "<div class='total-tooltip-artist'>" + firstArtist + "</div><div style='clear:both;'></div></div>" +
                    "<div class='total-playlist-songs' style='display:none'>" + playerHtml + "</div>" +
                    "<div id='total-flash-player' style='display:none;'> </div>");
                thisPlayer.find(".total-control-panel").height(50);
                thisPlayer.find(".total-play").css("bottom", "11px");
                thisPlayer.find(".total-next").css("bottom", "14px");
                thisPlayer.find(".total-previous").css("bottom", "14px");
                thisPlayer.find(".total-lcd-screen").css("margin-left", "0px").css("margin-right", "0px").css("left", "3px").css("height", "45px").css("width", "100px").css("background-size", "100px 45px");
                thisPlayer.find(".total-song-position, .total-song-duration").css("width", "40px");
                thisPlayer.find(".total-position-scrubber").css("left", "113px").css("bottom", "20px").css("width", "80px");
            }
            else {
                var _itemName = $('#item-type-name').html();
                thisPlayer.html("<div class='total-control-panel'>" +
                    "<div class='total-play'></div>" +
                    "<div class='total-next'></div><div class='total-previous'></div><div class='total-maximize'></div>" +
                    "<div class='total-add-song' onClick=''></div><div class='total-repeat-all'></div>" +
                    "<div class='total-repeat-one'></div><div class='total-shuffle'></div>" +
                    "<div class='total-lcd-screen'><div class='total-playing-title'>" + firstTitle + "</div>" +
//                    "<div class='total-playing-artist'>" + firstArtist + "</div>" +
                    "<div class='total-song-position'>0:00</div>" +
                    "<div class='total-song-duration'>0:00</div></div><div class='total-position-scrubber'></div>" +
                    "<div class='total-volume-slider'></div></div><div class='total-playlist-container'>" +
                    "<div class='total-row-labels'><div class='total-checked-label'></div>" +
                    "<div class='total-title-label'>"+_itemName+"</div><div class='total-artist-label'>"+_trans('reciter')+"</div><div style='clear:both;'></div></div>" +
                    "<div class='total-playlist-songs'>" + playerHtml + "</div>" +
                    "<div class='total-song-amount'>" + totalSongs + " "+_itemName+"</div>" +
                    "<div class='total-song-tooltip'><div class='total-artwork'></div>" +
                    "<div class='total-tooltip-title'>" + firstTitle + "</div><div class='total-tooltip-artist'>" + firstArtist + "</div>" +
                    "<div style='clear:both;'></div></div><div id='total-flash-player' style='display:none;'> </div>" +
                    "<div id='add-song-dialog' title='Add Song'>" +
                    "<form id='total-add-song-form'><fieldset><label for='total-add-ogg'>MP3 URL</label>" +
                    "<input type='text' name='total-add-mp3' id='total-add-mp3' class='text ui-widget-content ui-corner-all' />" +
                    "<label for='total-add-ogg'>OGG URL</label>" +
                    "<input type='text' name='total-add-ogg' id='total-add-ogg' class='text ui-widget-content ui-corner-all' />" +
                    "<label for='total-add-title'>Song Title</label>" +
                    "<input type='text' name='total-add-title' id='total-add-title' class='text ui-widget-content ui-corner-all' />" +
                    "<label for='total-add-artist'>Artist</label>" +
                    "<input type='text' name='total-add-artist' id='total-add-artist' class='text ui-widget-content ui-corner-all' />" +
                    "</fieldset></form></div>");
            }
            // Initialize sliders
            if (useFlash == "yes") {

                thisPlayer.find(".total-volume-slider").slider({
                    range:"max",
                    min:0,
                    max:100,
                    value:50,
                    slide:function (event, ui) {

                    }
                });

            }
            else {
                thisPlayer.find(".total-volume-slider").slider({
                    range:"max",
                    min:0,
                    max:1,
                    value:0.5,
                    step:0.01,
                    slide:function (event, ui) {

                    }
                });
            }

            thisPlayer.find(".total-position-scrubber").slider();

            // Configure player position
            if (options.position == "bottom") {
                thisPlayer.css("position", "fixed").css("bottom", "-12px");

                function setPlayerPosition() {
                    var newLeft = (window.innerWidth - 300) / 2;
                    thisPlayer.css("left", newLeft);

                }

                setInterval(setPlayerPosition, 10);
            }
            if (options.position == "bottomRight") {
                thisPlayer.css("position", "fixed").css("bottom", "-12px").css("right", "5px");

            }
            if (options.position == "bottomLeft") {
                thisPlayer.css("position", "fixed").css("bottom", "-12px").css("left", "5px");
            }


            ///////////////////////////////////////////////////////////////


            // Enable add songs
            thisPlayer.find("#add-song-dialog").dialog({
                autoOpen:false,
                modal:true,
                buttons:{
                    "OK":function () {
                        if ($.trim($("#total-add-mp3").attr("value")) == "" && $.trim($("#total-add-ogg").attr("value")) == "") {
                            alert("Song URL is required.");
                        }
                        else {
                            var newMp3 = $.trim($("#total-add-mp3").attr("value"));
                            var newOgg = $.trim($("#total-add-ogg").attr("value"));
                            var newTitle = $.trim($("#total-add-title").attr("value"));
                            if (newTitle == "") {
                                newTitle = " ";
                            }
                            var newArtist = $.trim($("#total-add-artist").attr("value"));
                            if (newArtist == "") {
                                newArtist = " ";
                            }
                            var newSrc = "";
                            if (supportOgg && supportMp3 && browser != "Safari") {
                                if (newOgg != "") {
                                    newSrc = newOgg;
                                }
                                else {
                                    newSrc = newMp3;
                                }
                                var newRow = "<div onClick='' class='total-row can-play' ><div type='checkbox' onClick='' class='total-checked'></div><div class='total-not-playing'></div><div class='total-title' src='" + newSrc + "'>" + newTitle + "</div><div class='total-artist'>" + newArtist + "</div><div style='clear:both;'></div></div>";
                                thisPlayer.find(".jspPane").append(newRow);
                            }
                            else if (supportOgg && browser != "Safari") {
                                if (newOgg != "") {
                                    newSrc = newOgg;
                                    var newRow = "<div onClick='' class='total-row can-play' ><div type='checkbox' onClick='' class='total-checked'></div><div class='total-not-playing'></div><div class='total-title' src='" + newSrc + "'>" + newTitle + "</div><div class='total-artist'>" + newArtist + "</div><div style='clear:both;'></div></div>";
                                    thisPlayer.find(".jspPane").append(newRow);
                                }
                            }
                            else if (supportMp3) {
                                if (newMp3 != "") {
                                    newSrc = newMp3;
                                    var newRow = "<div onClick='' class='total-row can-play' ><div type='checkbox' onClick='' class='total-checked'></div><div class='total-not-playing'></div><div class='total-title' src='" + newSrc + "'>" + newTitle + "</div><div class='total-artist'>" + newArtist + "</div><div style='clear:both;'></div></div>";
                                    thisPlayer.find(".jspPane").append(newRow);
                                }
                            }
                            else {
                                if (newOgg != "") {
                                    newSrc = newOgg;
                                }
                                else {
                                    newSrc = newMp3;
                                }

                                var newRow = "<div onClick='' class='total-row can-play' ><div type='checkbox' onClick='' class='total-checked'></div><div class='total-not-playing'></div><div class='total-title' src='" + newSrc + "'>" + newTitle + "</div><div class='total-artist'>" + newArtist + "</div><div style='clear:both;'></div></div>";
                                thisPlayer.find(".jspPane").append(newRow);
                            }


                            $("#add-song-dialog").dialog("close");
                            if (options.style = "default.css") {
                                if (options.style == "default.css") {
                                    thisPlayer.find(".total-row").css("background-color", "#FBFBFB");
                                    thisPlayer.find(".total-row:odd").css("background-color", "#F5F5F5");
                                }
                                if (options.style == "dark.css") {
                                    thisPlayer.find(".total-row").css("background-color", "#CCCCCC");
                                    thisPlayer.find(".total-row:odd").css("background-color", "#999999");
                                }
                                if (options.style == "light.css") {
                                    thisPlayer.find(".total-row").css("background-color", "#FBFBFB");
                                    thisPlayer.find(".total-row:odd").css("background-color", "#F5F5F5");
                                }
                            }
                        }
                    }
                }
            });

            if (options.addSongEnabled != true) {
                thisPlayer.find(".total-add-song").hide();
            }
            else {
                thisPlayer.find(".total-add-song").live("click", function () {
                    $("#add-song-dialog").dialog("open");
                });
            }
            ///////////////////////////////////////////////////////////////

            // Configure Draggability
            if (options.isDraggable == true && options.position == "relative") {
                thisPlayer.draggable({ handle:thisPlayer.find(".total-control-panel") });
            }
            ///////////////////////////////////////////////////////////////

            // Animate control buttons when clicked
            thisPlayer.find(".total-play, .total-next, .total-previous").live("mousedown", function () {
                $(this).css("opacity", "0.6");
            });

            thisPlayer.find(".total-play, .total-next, .total-previous").live("mouseup", function () {
                $(this).css("opacity", "1");
            })

            ///////////////////////////////////////////////////////////////

            // Configure playlist visibility
            if (options.playlistVisible == false) {
                thisPlayer.find(".total-playlist-container").hide();
            }
            else {
                thisPlayer.find(".total-maximize").live("click", function () {
                    if (thisPlayer.find(".total-playlist-songs").css("display") == "none") {
                        thisPlayer.find(".total-playlist-songs").slideDown();
                        thisPlayer.find(".total-row-labels").slideDown();
                        thisPlayer.find(".total-song-amount").slideDown();
                        if (options.position == "bottom" || options.position == "bottomLeft" || options.position == "bottomRight") {
                            thisPlayer.find(".total-control-panel").css("opacity", "1");
                        }
                    }
                    else {
                        thisPlayer.find(".total-playlist-songs").slideUp();
                        thisPlayer.find(".total-row-labels").slideUp();
                        thisPlayer.find(".total-song-amount").slideUp();
                        if (options.position == "bottom" || options.position == "bottomLeft" || options.position == "bottomRight") {
                            thisPlayer.find(".total-control-panel").css("opacity", "0.6");
                        }
                    }
                });
            }


            ////////////////////////////////////////////////////////////////

            // Configure song tooltip
            thisPlayer.find(".total-song-tooltip").hide();
            if (options.songTooltipEnabled != false) {

                if (options.songTooltipPosition == "top") {
                    thisPlayer.find(".total-song-tooltip").addClass("total-song-tooltip-top").removeClass("total-song-tooltip");
                    thisPlayer.find(".total-lcd-screen").hover(
                        function () {
                            thisPlayer.find(".total-song-tooltip-top").show();
                        },
                        function () {
                            thisPlayer.find(".total-song-tooltip-top").hide();
                        }
                    );
                }
                else {
                    thisPlayer.find(".total-lcd-screen").hover(
                        function () {
                            thisPlayer.find(".total-song-tooltip").show();
                        },
                        function () {
                            thisPlayer.find(".total-song-tooltip").hide();
                        }
                    );
                }


            }
            ////////////////////////////////////////////////////////////////

            // Customize song position scrubber
            thisPlayer.find(".total-position-scrubber a").css("height", "14px").css("width", "14px");
            ////////////////////////////////////////////////////////////////

            // Customize volume scrubber
            thisPlayer.find(".total-volume-slider a").css("height", "12px").css("width", "12px");
            ////////////////////////////////////////////////////////////////

            // Set max height of playlist
            thisPlayer.find(".total-playlist-songs").css("height", options.playlistHeight + "px");
            ////////////////////////////////////////////////////////////////

            // Attach custom scrollbar to playlist
            thisPlayer.find(".total-playlist-songs").jScrollPane({
                autoReinitialise:true,
                scrollbarWidth:0,
                scrollbarMargin:0
            });
            thisPlayer.find(".jspVerticalBar").css("margin-left", "0px");
            ////////////////////////////////////////////////////////////////


            // Set odd numbered playlist row background color based on style
            if (options.style == "default.css") {
                thisPlayer.find(".total-row").css("background-color", "#FBFBFB");
                thisPlayer.find(".total-row:odd").css("background-color", "#F5F5F5");
            }
            if (options.style == "dark.css") {
                thisPlayer.find(".total-row").css("background-color", "#CCCCCC");
                thisPlayer.find(".total-row:odd").css("background-color", "#999999");
            }
            if (options.style == "light.css") {
                thisPlayer.find(".total-row").css("background-color", "#FBFBFB");
                thisPlayer.find(".total-row:odd").css("background-color", "#F5F5F5");
            }
            ////////////////////////////////////////////////////////////////

            // Enable sortable playlist
            if (options.playlistSortable == true) {
                thisPlayer.find(".total-playlist-songs").sortable({
                    update:function () {
                        if (options.style = "default.css") {
                            thisPlayer.find(".total-row").css("background-color", "#FBFBFB");
                            thisPlayer.find(".total-row:odd").css("background-color", "#F5F5F5");
                        }
                        if (options.style = "dark.css") {
                            thisPlayer.find(".total-row").css("background-color", "#CCCCCC");
                            thisPlayer.find(".total-row:odd").css("background-color", "#999999");
                        }
                        if (options.style = "light.css") {
                            thisPlayer.find(".total-row").css("background-color", "#FBFBFB");
                            thisPlayer.find(".total-row:odd").css("background-color", "#F5F5F5");
                        }
                    },
                    items:'.total-row'
                });
            }
            ////////////////////////////////////////////////////////////////

            // Enable checkboxes
            if (options.checkboxesEnabled == true) {
                thisPlayer.find("[type=checkbox]").live("click", function () {

                    $(this).toggleClass('total-unchecked');
                    $(this).parent().toggleClass('can-play');
                });
            }
            ////////////////////////////////////////////////////////////////

            // Enable repeat all
            if (options.repeatAllEnabled == true) {
                thisPlayer.find(".total-repeat-all").live("click", function () {

                    $(this).toggleClass('total-repeat-all-active');
                    if ($(this).hasClass("total-repeat-all-active")) {
                        thisPlayer.find("*").removeClass("total-shuffle-active")
                        thisPlayer.find("*").removeClass("total-repeat-one-active");
                    }
                    else {

                    }
                });

                thisPlayer.find(".total-repeat-all").addClass("total-repeat-all-active");
            }
            else {
                thisPlayer.find(".total-repeat-all").css("opacity", "0.2");
            }
            ////////////////////////////////////////////////////////////////

            // Enable repeat one
            if (options.repeatOneEnabled == true) {
                thisPlayer.find(".total-repeat-one").live("click", function () {

                    $(this).toggleClass('total-repeat-one-active');
                    if ($(this).hasClass("total-repeat-one-active")) {
                        thisPlayer.find("*").removeClass("total-shuffle-active")
                        thisPlayer.find("*").removeClass("total-repeat-all-active");
                    }
                    else {

                    }
                });
            }
            else {
                thisPlayer.find(".total-repeat-one").css("opacity", "0.2");
            }
            ////////////////////////////////////////////////////////////////

            // Enable shuffle
            if (options.shuffleEnabled == true) {
                thisPlayer.find(".total-shuffle").live("click", function () {

                    $(this).toggleClass('total-shuffle-active');
                    if ($(this).hasClass("total-shuffle-active")) {
                        thisPlayer.find("*").removeClass("total-repeat-all-active")
                        thisPlayer.find("*").removeClass("total-repeat-one-active");
                    }
                    else {

                    }
                });


            }
            else {
                thisPlayer.find(".total-shuffle").css("opacity", "0.2");
            }
            ////////////////////////////////////////////////////////////////


            // Minimize player if position not set to "relative"
            if (options.position == "bottom" || options.position == "bottomLeft" || options.position == "bottomRight") {
                thisPlayer.find(".total-maximize").trigger("click");
            }


            // Calculate and format song duration/current song position
            function convertMilliseconds(ms, p) {

                var pattern = p || "hh:mm:ss",
                    arrayPattern = pattern.split(":"),
                    clock = [ ],
                    hours = Math.floor(ms / 3600000), // 1 Hour = 36000 Milliseconds
                    minuets = Math.floor(( ms % 3600000) / 60000), // 1 Minutes = 60000 Milliseconds
                    seconds = Math.floor((( ms % 360000) % 60000) / 1000) // 1 Second = 1000 Milliseconds


                // build the clock result
                function createClock(unit) {


                    // match the pattern to the corresponding variable
                    if (pattern.match(unit)) {
                        if (unit.match(/h/)) {
                            addUnitToClock(hours, unit);
                        }
                        if (unit.match(/m/)) {
                            addUnitToClock(minuets, unit);
                        }
                        if (unit.match(/s/)) {
                            addUnitToClock(seconds, unit);
                        }
                        ;
                    }
                }

                function addUnitToClock(val, unit) {

                    if (val < 10 && unit.length === 2) {
                        val = "0" + val;
                    }

                    clock.push(val); // push the values into the clock array

                }


                // loop over the pattern building out the clock result
                for (var i = 0, j = arrayPattern.length; i < j; i++) {

                    createClock(arrayPattern[i]);

                }

                return {
                    hours:hours,
                    minuets:minuets,
                    seconds:seconds,
                    clock:clock.join(":")
                };

            }

            var currentRow = thisPlayer.find(".total-row:first");
            // Create global HTML5 audio object
            var htmlSound = new Audio();

            // Create global SoundManager audio object
            var mySound = soundManager.createSound();

            // Play //////////////////////
            var firstSrc = thisPlayer.find("[src]:first").attr("src");
            if (thisPlayer.find(".total-row:first").attr("artwork")) {
                var currentArtwork = thisPlayer.find(".total-row:first").attr("artwork");
                thisPlayer.find(".total-artwork").html("<img src='" + currentArtwork + "' width='50' height='50' />");
            }
            else {
                thisPlayer.find(".total-artwork:first").html("");
            }

            function songPlay(newSrc) {
                if (useFlash == "no") {

                    htmlSound.src = newSrc;
                    htmlSound.load();

                    thisPlayer.find(".total-position-scrubber").bind("slide", function (event, ui) {
                        htmlSound.currentTime = ui.value;
                    });

                    var currentArtist = currentRow.find(".total-artist").text();
                    var currentTitle = currentRow.find(".total-title").text();

                   // thisPlayer.find(".total-playing-artist").html(currentArtist);
                    thisPlayer.find(".total-playing-title").html(currentTitle);

                    htmlSound.addEventListener("timeupdate", function () {
                        var newVolume = thisPlayer.find(".total-volume-slider").slider("option", "value");
                        htmlSound.volume = newVolume;

                        var duration = htmlSound.duration * 1000;
                        var durationTime = convertMilliseconds(duration, "mm:ss");
                        thisPlayer.find(".total-song-duration").html(durationTime.clock);

                        var position = htmlSound.currentTime * 1000;
                        var positionTime = convertMilliseconds(position, "mm:ss");
                        thisPlayer.find(".total-song-position").html(positionTime.clock);

                        thisPlayer.find(".total-position-scrubber").slider("option", "max", duration / 1000);
                        thisPlayer.find(".total-position-scrubber").slider("option", "value", position / 1000);

                    });


                    thisPlayer.find(".total-row .total-not-playing").removeClass("total-playing");
                    currentRow.find(".total-not-playing").addClass("total-playing");
                }
                else if (useFlash == "yes") {
                    thisPlayer.find(".total-position-scrubber").bind("slide", function (event, ui) {
                        mySound.setVolume(ui.value);
                    });
                    var currentArtist = currentRow.find(".total-artist").text();
                    var currentTitle = currentRow.find(".total-title").text();

                 //   thisPlayer.find(".total-playing-artist").html(currentArtist);
                    thisPlayer.find(".total-playing-title").html(currentTitle);

                    soundManager.destroySound('total-flash-player');
                    mySound = soundManager.createSound({
                        id:'total-flash-player',
                        url:newSrc,
                        onload:function () {
                            var duration = mySound.duration;
                            thisPlayer.find(".total-position-scrubber").slider("option", "max", duration);
                            var durationTime = convertMilliseconds(duration, "mm:ss");
                            thisPlayer.find(".total-song-duration").attr("value", durationTime.clock);
                            thisPlayer.find(".total-position-scrubber").bind("slide", function (event, ui) {
                                mySound.setPosition(ui.value);
                            });
                        },
                        whileplaying:function () {
                            var position = mySound.position;
                            var positionTime = convertMilliseconds(position, "mm:ss");
                            thisPlayer.find(".total-song-position").html(positionTime.clock);
                            thisPlayer.find(".total-position-scrubber").slider("option", "value", position);
                            var volume = thisPlayer.find(".total-volume-slider").slider("option", "value");
                            mySound.setVolume(volume);
                        },
                        whileloading:function () {
                            var duration = mySound.duration;
                            var durationTime = convertMilliseconds(duration, "mm:ss");
                            thisPlayer.find(".total-song-duration").html(durationTime.clock);

                        },
                        onfinish:function () {
                            // Repeat all is acive
                            if (thisPlayer.find(".total-repeat-all-active").length > 0) {
                                // Find next checked song
                                currentRow = currentRow.nextAll(".can-play:first");

                                // If checked song exists after current song, load it
                                if (currentRow.length > 0) {
                                    var newSrc = currentRow.find("[src]").attr("src");
                                    songPlay(newSrc);
                                }

                                else {
                                    // If no checked song exists after current song, load the first checked song in playlist
                                    if (thisPlayer.find(".can-play").length > 0) {
                                        currentRow = thisPlayer.find(".can-play:first");
                                        var newSrc = currentRow.find("[src]").attr("src");
                                        songPlay(newSrc);
                                    }
                                    // Change pause button to play button
                                    else {
                                        thisPlayer.find(".total-play").removeClass("total-pause");
                                    }

                                }
                                // If song is playing while next button is clicked play next song
                                if (thisPlayer.find(".total-pause").length > 0) {
                                    mySound.play();

                                }
                            }
                            // Repeat one is active
                            else if (thisPlayer.find(".total-repeat-one-active").length > 0) {
                                // If current song is checked load it
                                if (currentRow.hasClass("can-play")) {
                                    var newSrc = currentRow.find("[src]").attr("src");
                                    mySound.play();
                                }
                                else {

                                }

                            }
                            // Shuffle is active
                            else if (thisPlayer.find(".total-shuffle-active").length > 0) {
                                var songAmount = thisPlayer.find(".can-play").length;
                                var randomSong = Math.floor(Math.random() * (songAmount));
                                console.log(randomSong);
                                if (songAmount > 0) {
                                    currentRow = thisPlayer.find(".can-play:eq(" + randomSong + ")");
                                    var newSrc = currentRow.find("[src]").attr("src");
                                    songPlay(newSrc);
                                    mySound.play();
                                }
                                else {

                                }
                            }
                            // No playlist functions are active
                            else {
                                thisPlayer.find(".total-play").removeClass("total-pause");
                            }

                        }
                    });
                    thisPlayer.find(".total-row .total-not-playing").removeClass("total-playing");
                    currentRow.find(".total-not-playing").addClass("total-playing");


                }
                // Set song artwork
                if (currentRow.attr("artwork")) {
                    var currentArtwork = currentRow.attr("artwork");
                    thisPlayer.find(".total-artwork").html("<img src='" + currentArtwork + "' width='50' height='50' />");
                    thisPlayer.find(".total-tooltip-title").html(currentRow.find(".total-title").html());
                    thisPlayer.find(".total-tooltip-artist").html(currentRow.find(".total-artist").html());
                }
                else {
                    thisPlayer.find(".total-artwork").html("");
                    thisPlayer.find(".total-tooltip-title").html(currentRow.find(".total-title").html());
                    thisPlayer.find(".total-tooltip-artist").html(currentRow.find(".total-artist").html());
                }
            }///// End songPlay()

            htmlSound.addEventListener("ended", function () {
                // Repeat all is acive
                if (thisPlayer.find(".total-repeat-all-active").length > 0) {
                    // Find next checked song
                    currentRow = currentRow.nextAll(".can-play:first");


                    // If checked song exists after current song, load it
                    if (currentRow.length > 0) {
                        var newSrc = currentRow.find("[src]").attr("src");
                        songPlay(newSrc);

                    }

                    else {
                        // If no checked song exists after current song, load the first checked song in playlist
                        if (thisPlayer.find(".can-play").length > 0) {
                            currentRow = thisPlayer.find(".can-play:first");
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        // Change pause button to play button
                        else {
                            thisPlayer.find(".total-play").removeClass("total-pause");
                        }

                    }
                    // If song is playing while next button is clicked play next song
                    if (thisPlayer.find(".total-pause").length > 0) {

                        htmlSound.play();

                    }
                }
                // Repeat one is active
                else if (thisPlayer.find(".total-repeat-one-active").length > 0) {
                    // If current song is checked load it
                    if (currentRow.hasClass("can-play")) {
                        var newSrc = currentRow.find("[src]").attr("src");
                        songPlay(newSrc);
                        htmlSound.play();
                    }
                    else {

                    }

                }
                // Shuffle is active
                else if (thisPlayer.find(".total-shuffle-active").length > 0) {
                    var songAmount = thisPlayer.find(".can-play").length;
                    var randomSong = Math.floor(Math.random() * (songAmount));
                    console.log(randomSong);
                    if (songAmount > 0) {
                        currentRow = thisPlayer.find(".can-play:eq(" + randomSong + ")");
                        var newSrc = currentRow.find("[src]").attr("src");
                        songPlay(newSrc);
                        htmlSound.play();
                    }
                    else {

                    }
                }
                // No playlist functions are active
                else {
                    thisPlayer.find(".total-play").removeClass("total-pause");
                }

            });

            // Enable autoplay
            if (options.autoplayEnabled == true) {

                if (useFlash == "no") {
                    songPlay(firstSrc);
                    if ((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i))) {

                    }
                    else {
                        thisPlayer.find(".total-play").addClass("total-pause");
                        htmlSound.play();

                    }
                }
                else {
                    soundManager.onready(function () {
                        songPlay(firstSrc);
                        thisPlayer.find(".total-play").trigger("click");

                    });
                }


            }
            else {
                if (useFlash == "yes") {

                    soundManager.onready(function () {
                        songPlay(firstSrc);


                    });
                }
                else {
                    songPlay(firstSrc);
                }
            }


            // Next Button
            thisPlayer.find(".total-next").live("click", function () {
                if (useFlash == "no") {
                    // Repeat one is active
                    if (thisPlayer.find(".total-repeat-one-active").length > 0) {
                        // If current song is checked load it
                        if (currentRow.hasClass("can-play")) {
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        else {

                        }
                    }
                    // Shuffle is active
                    else if (thisPlayer.find(".total-shuffle-active").length > 0) {

                        var songAmount = thisPlayer.find(".can-play").length;
                        var randomSong = Math.floor(Math.random() * (songAmount));
                        console.log(randomSong);
                        if (songAmount > 0) {
                            currentRow = thisPlayer.find(".can-play:eq(" + randomSong + ")");
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        else {

                        }
                    }
                    // Repeat all is active or all playlist functions are inactive
                    else {
                        // Find next checked song
                        currentRow = currentRow.nextAll(".can-play:first");

                        // If checked song exists after current song, load it
                        if (currentRow.length > 0) {
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        // If no checked song exists after current song, load the first checked song in playlist
                        else {
                            if (thisPlayer.find(".can-play").length > 0) {
                                currentRow = thisPlayer.find(".can-play:first");
                                var newSrc = currentRow.find("[src]").attr("src");
                                songPlay(newSrc);
                            }

                        }
                    }

                    // If song is playing while next button is clicked play next song
                    if (thisPlayer.find(".total-pause").length > 0) {
                        htmlSound.play();

                    }
                }
                else {
                    // Repeat one is active
                    if (thisPlayer.find(".total-repeat-one-active").length > 0) {
                        // If current song is checked load it
                        if (currentRow.hasClass("can-play")) {
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        else {

                        }
                    }
                    // Shuffle is active
                    else if (thisPlayer.find(".total-shuffle-active").length > 0) {

                        var songAmount = thisPlayer.find(".can-play").length;
                        var randomSong = Math.floor(Math.random() * (songAmount));
                        console.log(randomSong);
                        if (songAmount > 0) {
                            currentRow = thisPlayer.find(".can-play:eq(" + randomSong + ")");
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        else {

                        }
                    }
                    // Repeat all is active or all playlist functions are inactive
                    else {
                        // Find next checked song
                        currentRow = currentRow.nextAll(".can-play:first");

                        // If checked song exists after current song, load it
                        if (currentRow.length > 0) {
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        // If no checked song exists after current song, load the first checked song in playlist
                        else {
                            if (thisPlayer.find(".can-play").length > 0) {
                                currentRow = thisPlayer.find(".can-play:first");
                                var newSrc = currentRow.find("[src]").attr("src");
                                songPlay(newSrc);
                            }

                        }
                    }

                    // If song is playing while next button is clicked play next song
                    if (thisPlayer.find(".total-pause").length > 0) {
                        mySound.play();

                    }
                }

            });

            // Previous Button
            thisPlayer.find(".total-previous").live("click", function () {
                if (useFlash == "no") {
                    // Repeat one is active
                    if (thisPlayer.find(".total-repeat-one-active").length > 0) {
                        // If current song is checked load it
                        if (currentRow.hasClass("can-play")) {
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        else {

                        }
                    }
                    // Shuffle is active
                    else if (thisPlayer.find(".total-shuffle-active").length > 0) {

                        var songAmount = thisPlayer.find(".can-play").length;
                        var randomSong = Math.floor(Math.random() * (songAmount));
                        console.log(randomSong);
                        if (songAmount > 0) {
                            currentRow = thisPlayer.find(".can-play:eq(" + randomSong + ")");
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        else {

                        }
                    }
                    // Repeat all is active or all playlist functions are inactive
                    else {
                        // Find next checked song
                        currentRow = currentRow.prevAll(".can-play:first");

                        // If checked song exists after current song, load it
                        if (currentRow.length > 0) {
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        // If no checked song exists after current song, load the first checked song in playlist
                        else {
                            if (thisPlayer.find(".can-play").length > 0) {
                                currentRow = thisPlayer.find(".can-play:first");
                                var newSrc = currentRow.find("[src]").attr("src");
                                songPlay(newSrc);
                            }

                        }
                    }

                    // If song is playing while next button is clicked play next song
                    if (thisPlayer.find(".total-pause").length > 0) {
                        htmlSound.play();


                    }
                }
                else {
                    // Repeat one is active
                    if (thisPlayer.find(".total-repeat-one-active").length > 0) {
                        // If current song is checked load it
                        if (currentRow.hasClass("can-play")) {
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        else {

                        }
                    }
                    // Shuffle is active
                    else if (thisPlayer.find(".total-shuffle-active").length > 0) {

                        var songAmount = thisPlayer.find(".can-play").length;
                        var randomSong = Math.floor(Math.random() * (songAmount));
                        console.log(randomSong);
                        if (songAmount > 0) {
                            currentRow = thisPlayer.find(".can-play:eq(" + randomSong + ")");
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        else {

                        }
                    }
                    // Repeat all is active or all playlist functions are inactive
                    else {
                        // Find next checked song
                        currentRow = currentRow.prevAll(".can-play:first");

                        // If checked song exists after current song, load it
                        if (currentRow.length > 0) {
                            var newSrc = currentRow.find("[src]").attr("src");
                            songPlay(newSrc);
                        }
                        // If no checked song exists after current song, load the first checked song in playlist
                        else {
                            if (thisPlayer.find(".can-play").length > 0) {
                                currentRow = thisPlayer.find(".can-play:first");
                                var newSrc = currentRow.find("[src]").attr("src");
                                songPlay(newSrc);
                            }

                        }
                    }

                    // If song is playing while next button is clicked play next song
                    if (thisPlayer.find(".total-pause").length > 0) {
                        mySound.play();

                    }
                }

            });

            // Play button

            thisPlayer.find(".total-play").live("click", function () {
                if (useFlash == "no") {
                    // Pause song
                    if ($(this).hasClass("total-pause")) {
                        htmlSound.pause();
                        $(this).removeClass("total-pause");

                    }
                    // Play song
                    else {
                        htmlSound.play();
                        $(this).addClass("total-pause");


                        htmlSound.addEventListener("timeupdate", function () {
                            var newVolume = thisPlayer.find(".total-volume-slider").slider("option", "value");
                            htmlSound.volume = newVolume;

                            var duration = htmlSound.duration * 1000;
                            var durationTime = convertMilliseconds(duration, "mm:ss");
                            thisPlayer.find(".total-song-duration").html(durationTime.clock);

                            var position = htmlSound.currentTime * 1000;
                            var positionTime = convertMilliseconds(position, "mm:ss");
                            thisPlayer.find(".total-song-position").html(positionTime.clock);

                            thisPlayer.find(".total-position-scrubber").slider("option", "max", duration / 1000);
                            thisPlayer.find(".total-position-scrubber").slider("option", "value", position / 1000);

                        });
                    }


                }
                else {
                    // Pause song
                    if ($(this).hasClass("total-pause")) {
                        mySound.pause();
                        $(this).removeClass("total-pause");

                    }
                    // Play song
                    else {
                        mySound.play();
                        $(this).addClass("total-pause");

                    }
                }
            });


            var lastClickTime;
            var lastClickObject;
            // Double click play song
            thisPlayer.find(".total-row").live("click", function () {

                if (lastClickObject == $(this).index()) {
                    var newClickTime = new Date().getTime();
                    var timeDelta = newClickTime - lastClickTime;

                    if (timeDelta < 350) {
                        if (useFlash == "no") {
                            var newSrc = $(this).find("[src]").attr("src");
                            currentRow = $(this);
                            songPlay(newSrc);
                            htmlSound.play();
                            htmlSound.addEventListener("timeupdate", function () {
                                var newVolume = thisPlayer.find(".total-volume-slider").slider("option", "value");
                                htmlSound.volume = newVolume;

                                var duration = htmlSound.duration * 1000;
                                var durationTime = convertMilliseconds(duration, "mm:ss");
                                thisPlayer.find(".total-song-duration").html(durationTime.clock);

                                var position = htmlSound.currentTime * 1000;
                                var positionTime = convertMilliseconds(position, "mm:ss");
                                thisPlayer.find(".total-song-position").html(positionTime.clock);

                                thisPlayer.find(".total-position-scrubber").slider("option", "max", duration / 1000);
                                thisPlayer.find(".total-position-scrubber").slider("option", "value", position / 1000);

                            });
                            if (thisPlayer.find(".total-play").hasClass("total-pause")) {

                            }
                            else {
                                thisPlayer.find(".total-play").addClass("total-pause");
                            }
                        }
                        else {
                            var newSrc = $(this).find("[src]").attr("src");
                            currentRow = $(this);
                            songPlay(newSrc);
                            mySound.play();

                            if (thisPlayer.find(".total-play").hasClass("total-pause")) {

                            }
                            else {
                                thisPlayer.find(".total-play").addClass("total-pause");
                            }
                        }
                    }

                }
                lastClickTime = new Date().getTime();
                lastClickObject = $(this).index();


            });

            function volumeTime() {
                if (navigator.userAgent.indexOf("Opera") > -1) {
                    if (useFlash == "no") {
                        console.log(htmlSound.currentTime);
                        var newVolume = thisPlayer.find(".total-volume-slider").slider("option", "value");
                        htmlSound.volume = newVolume;

                        var duration = htmlSound.duration * 1000;
                        var durationTime = convertMilliseconds(duration, "mm:ss");
                        thisPlayer.find(".total-song-duration").html(durationTime.clock);

                        var position = htmlSound.currentTime * 1000;
                        var positionTime = convertMilliseconds(position, "mm:ss");
                        thisPlayer.find(".total-song-position").html(positionTime.clock);

                        thisPlayer.find(".total-position-scrubber").slider("option", "max", duration / 1000);
                        thisPlayer.find(".total-position-scrubber").slider("option", "value", position / 1000);
                    }
                    else {
                        var currentPosition = soundManager.getSoundById('total-flash-player').position;
                        console.log(currentPosition);

                        var duration = mySound.duration;
                        thisPlayer.find(".total-position-scrubber").slider("option", "max", duration);
                        var durationTime = convertMilliseconds(duration, "mm:ss");
                        thisPlayer.find(".total-song-duration").attr("value", durationTime.clock);
                        thisPlayer.find(".total-position-scrubber").bind("slide", function (event, ui) {
                            mySound.setPosition(ui.value);
                        });

                        var position = mySound.position;
                        var positionTime = convertMilliseconds(position, "mm:ss");
                        thisPlayer.find(".total-song-position").html(positionTime.clock);
                        thisPlayer.find(".total-position-scrubber").slider("option", "value", position);
                        var volume = thisPlayer.find(".total-volume-slider").slider("option", "value");
                        mySound.setVolume(volume);
                        var duration = mySound.duration;
                        var durationTime = convertMilliseconds(duration, "mm:ss");
                        thisPlayer.find(".total-song-duration").html(durationTime.clock);
                    }
                }
            }

            setInterval(volumeTime, 1000);

            ////////////////////////////////////////////////////////////////
        });/// End return this.each(function () {})


    };
})(jQuery);