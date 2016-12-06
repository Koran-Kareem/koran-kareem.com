
/* START PLAYER API */

function api_playAudio(player){
    if(player)player.playAudio();
}
function api_pauseAudio(player){
    if(player)player.pauseAudio();
}
function api_toggleAudio(player){
    if(player)player.toggleAudio();
}
function api_stopAudio(player){
    if(player)player.stopAudio();
}
function api_checkAudio(player, action){
    if(player)player.checkAudio(action);
}
function api_nextAudio(player){
    if(player)player.nextAudio();
}
function api_previousAudio(player){
    if(player)player.previousAudio();
}
function api_loadAudio(player, id){
    if(player)player.loadAudio(id);
}
function api_loadPlaylist(player, id){
    if(player)player.loadPlaylist(id);
}
function api_addTrack(player, type, format, tracks, pos){
    if(player)player.addTrack(type, format, tracks, pos);
}
function api_inputAudio(player, track){
    if(player)player.inputAudio(track);
}
function api_removeTrack(player, id){
    if(player)player.removeTrack(id);
}
function api_destroyAudio(player){
    if(player)player.destroyAudio();
}
function api_destroyPlaylist(player){
    if(player)player.destroyPlaylist();
}
function api_toggleShuffle(player){
    if(player)player.toggleShuffle();
}
function api_toggleLoop(player){
    if(player)player.toggleLoop();
}
function api_checkScroll(player){
    if(player)player.checkScroll();
}
function api_reinitScroll(player){
    if(player)player.reinitScroll();
}
function api_orderPlaylist(player, action, data){
    if(player)player.orderPlaylist(action, data);
}


/* GETTERS - SETTERS */
function api_getVolume(player){
    if(player)return player.getVolume();
}
function api_setVolume(player, val){
    if(player)player.setVolume(val);
}
function api_getAutoPlay(player){
    if(player)return player.getAutoPlay();
}
function api_setAutoPlay(player, val){
    if(player)player.setAutoPlay(val);
}
function api_setTitle(player, val){
    if(player)player.setTitle(val);
}
function api_getSetupDone(player){
    if(player)return player.getSetupDone();
}
function api_getPlaylistLoaded(player){
    if(player)return player.getPlaylistLoaded();
}
function api_getPlaylistTransition(player){
    if(player)return player.getPlaylistTransition();
}
function api_getMediaPlaying(player){
    if(player)return player.getMediaPlaying();
}
function api_getAudioInited(player){
    if(player)return player.getAudioInited();
}
function api_getMediaType(player){
    if(player)return player.getMediaType();
}
function api_getActiveItem(player){
    if(player)return player.getActiveItem();
}
function api_getPlaylistItems(player, value){
    if(player)return player.getPlaylistItems(value);
}
function api_getMediaCount(player){
    if(player)return player.getMediaCount();
}
function api_getPlaylistHidden(player){
    if(player)return player.getPlaylistHidden();
}
function api_getPlaylistList(player){
    if(player)return player.getPlaylistList();
}
function api_getPlaylistData(player){
    if(player)return player.getPlaylistData();
}
function api_getSoundId(player){
    if(player)return player.getSoundId();
}

/* END PLAYER API */


/* START PLAYER CALLBACKS */

function audioPlayerSetupDone(instance, sound_id){
    /* called when component is ready to use public API. Returns player instance, sound id. */
    //console.log('audioPlayerSetupDone: ', sound_id);

    if(sound_id == 'popup' || sound_id == 'classic_popup'){
        instance.find('.popup_open').css({cursor:'pointer', display:'block'}).bind('click', function(){
            open_popup(popup_url, popup_width, popup_height, resizable);
            return false;
        });
    }else if(sound_id == 'circle_slideshow' || sound_id == 'bg_slideshow'){
        loadImage();
    }

    //remove hover if touch
    if(sound_id == 'classic_single' || sound_id == 'classic' || sound_id == 'classic_white' || sound_id == 'classic_no_time' || sound_id == 'classic_full' || sound_id == 'classic_no_time_advance' || sound_id == 'classic_no_time_no_seekbar_advance' || sound_id == 'classic_min' || sound_id == 'classic_playlist' || sound_id == 'classic_popup' || sound_id == 'wall'|| sound_id == 'drag_to_play' || /wrap_multi/g.test(sound_id)){
        if(instance.getTouch()){
            instance.find('.controls_toggle').addClass('hap_no_hover');
            instance.find('.player_volume').addClass('hap_no_hover');
            instance.find('.controls_prev').addClass('hap_no_hover');
            instance.find('.controls_next').addClass('hap_no_hover');
            instance.find('.popup_open').addClass('hap_no_hover');
        }
    }


    //create audio after component init!
    if(typeof(hap_group) !== 'undefined'){
        if(hap_group == 'wrap_multi' || hap_group == 'wrap_multi2'){
            if(hap_group == 'wrap_multi2' && sound_id == 'wrap_multi2_selector') return;

            var track, type, mp3, ogg='', title, thumb, download, _item = jQuery(instance).closest('.playlistItem');
            if(_item.attr('data-type') != undefined) type = _item.attr('data-type');
            if(_item.attr('data-mp3') != undefined) mp3 = _item.attr('data-mp3');
            if(type && mp3){
                if(_item.attr('data-ogg') != undefined) ogg = _item.attr('data-ogg');
                if(_item.attr('data-title') != undefined) title = _item.attr('data-title');
                if(_item.attr('data-thumb') != undefined) thumb = _item.attr('data-thumb');
                if(_item.attr('data-download') != undefined) download = _item.attr('data-download');

                //since we process each track from playlist selector, we want all types to be 'local' when using api_addTrack! (otherwise process track would fail for non local type because we would be trying to process already processed track, and there is no point in doing it once again). So we set local type just for the api_addTrack so the track gets added into the playlist without processing, then afterwards switch types! (maybe local type could be left for all types except youtube, whose playback is treated differently but we bring back original type for all types nevertheless)

                track = [{type: 'local', origtype:type, mp3: mp3, ogg: ogg, title: title, thumb: thumb, download: download}];
                //console.log(track);
                instance.addTrack('visible', 'data', track[0]);
            }
        }
    }
}
function audioPlayerPlaylistLoaded(instance, sound_id){
    /* called when playlist is loaded. Returns player instance, sound id. */
    //console.log('audioPlayerPlaylistLoaded: ', sound_id);

    if(typeof(hap_group) !== 'undefined'){
        if(hap_group == 'wrap_multi2' && sound_id == 'wrap_multi2_selector'){
            makeHapPlayers(instance);
        }
    }

    if(sound_id == 'drag_text1' || sound_id == 'drag_thumb1'){
        //make draggable from playlist selector into player playlist
        instance.find("li[class*=hap_draggable]").draggable({
            connectToSortable: ".hap_sortable",
            helper: "clone",
            revert: "invalid"
        });
    }
    else if(sound_id == 'drag_text2' || sound_id == 'drag_thumb2'){
        //console.log(jQuery("#playlist2").hasClass('ui-droppable'));
        //action when item is dropped from playlist selector into player playlist
        jQuery("#playlist2").droppable({
            tolerance: "touch",
            drop: function(event, ui) {
                //draggable item
                //console.log(jQuery(ui.draggable));
                var _item = jQuery(ui.draggable);
                //remove locked
                if(_item.hasClass('playlist_locked')){
                    _item.removeClass('playlist_locked');
                }
            }
        });
    }

    //enable selector
    if(jQuery("#hap_playlist").length)jQuery("#hap_playlist").selectbox("enable");
}
function audioPlayerPlaylistEnd(instance, sound_id){
    /* called when current playlists reaches end. Returns player instance, sound id. */
    //console.log('audioPlayerPlaylistEnd: ');
}
function audioPlayerSoundEnd(instance, sound_id, counter){
    /* called when current playing sound ends. Returns player instance, sound id, media counter. */
    //console.log('audioPlayerSoundEnd: ');
}
function audioPlayerSoundStart(instance, sound_id, counter){
    /* called when current playing sound starts. Returns player instance, sound id, media counter. */
    //console.log('audioPlayerSoundStart: ', sound_id);
}
function audioPlayerSoundPlay(instance, sound_id, counter){
    /* called when sound is played. Returns player instance, sound id, media counter. */
    //console.log('audioPlayerSoundPlay: ');

    if(typeof(hap_group) !== 'undefined' && typeof(hap_players) !== 'undefined' && hap_players.length && typeof(soundArr) !== 'undefined' && soundArr.length){
        var i = 0, len = soundArr.length;
        for(i;i<len;i++){
            if(sound_id != soundArr[i].sound_id){
                //console.log('audioPlayerSoundPlay: ', sound_id, soundArr[i].sound_id);
                if(typeof api_checkAudio !== 'undefined')api_checkAudio(soundArr[i].player_id, 'pause');
            }
        }
    }
}
function audioPlayerSoundPause(instance, sound_id, counter){
    /* called when sound is paused. Returns player instance, sound id, media counter. */
    //console.log('audioPlayerSoundPause: ', sound_id);
}
function itemTriggered(instance, sound_id, counter){
    /* called when new sound is triggered. Returns player instance, sound_id, media counter. */
    //console.log('itemTriggered: ');

    if(sound_id == 'artwork1' || sound_id == 'basic' || sound_id == 'basic_h'){
        var player_thumb = instance.find('.player_thumb').find('img'),
            data = instance.getPlaylistData(),
            thumb = data[counter].thumb;
        if(player_thumb.length && thumb){
            //console.log(thumb);
            player_thumb.attr('src', instance.get_hap_source_path() + thumb);
        }
    }
}
function playlistItemEnabled(instance, sound_id, target, id){
    /* called on playlist item enable. Returns player instance, sound_id, playlist item (target), playlist item id (playlist items have data-id attributes starting from 0). */
    //console.log('playlistItemEnabled: ');

    if(sound_id == 'wall'){
        jQuery(target).find('p[class=hap_title]').remove();
    }
}
function playlistItemDisabled(instance, sound_id, target, id){
    /* called on playlist item disable. Returns player instance, sound_id, playlist item (target), playlist item id (playlist items have data-id attributes starting from 0). */
    //console.log('playlistItemDisabled: ');

    if(sound_id == 'wall'){
        var data = instance.getPlaylistData(),
            title = data[id].title;
        if(title){
            var p = jQuery('<p>"'+title+'"</p>').addClass('hap_title');
            p.appendTo(jQuery(target)).css('marginTop',-p.outerHeight(true)/2+'px');
        }
    }
}
function playlistItemRollover(instance, sound_id, target, id, active){
    /* called on playlist item mouseenter. Returns player instance, sound_id, playlist item (target), playlist item id (playlist items have data-id attributes starting from 0), active (is active playlist item, boolean). */
    //console.log('playlistItemRollover: ');
    if(sound_id == 'wall' && !active){
        var data = instance.getPlaylistData(),
            title = data[id].title;
        if(title){
            var p = jQuery('<p>"'+title+'"</p>').addClass('hap_title');
            p.appendTo(jQuery(target)).css('marginTop',-p.outerHeight(true)/2+'px');
        }
    }

}
function playlistItemRollout(instance, sound_id, target, id, active){
    /* called on playlist item mouseleave. Returns player instance, sound_id, playlist item (target), playlist item id (playlist items have data-id attributes starting from 0), active (is active playlist item, boolean). */
    //console.log('playlistItemRollout: ');
    if(sound_id == 'wall' && !active){
        jQuery(target).find('p[class=hap_title]').remove();
    }

}
function playlistEmpty(instance, sound_id){
    /* called when playlist becomes empty (no items in playlist after new playlist has been created or last playlist item removed from playlist). Returns player instance, sound_id. */
    //console.log('playlistEmpty: ', sound_id);
    if(sound_id == 'drag_text2' || sound_id == 'drag_thumb2'){
        instance.destroyAudio();
        if(instance.find('p[class=drag_info]').length==0){
            instance.find('.playlist_inner').prepend($('<p class="drag_info">DRAG THE SONGS IN HERE!</p>'));
            instance.loadPlaylist({hidden: false, id: '#playlist2'});

        }
    }
}
function dropReceive(instance, sound_id){
    /* called when item gets dropped into the playlist. Returns player instance, sound_id. */
    //console.log('dropReceive: ');
    if(sound_id == 'drag_text2' || sound_id == 'drag_thumb2'){
        instance.find('p[class=drag_info]').remove();
    }
}

/* END PLAYER CALLBACKS */


/* START TRACK LIST FOR PLAYER API */

/**** html formatted tracks ****/

var trackList_local1 = [
    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.mp3' 		 data-ogg='../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.ogg' data-download><a class='playlistNonSelected' href='#'>Tim McMorris - A Bright And Hopeful Future</a><a class='dlink' href='#' data-dlink='../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.mp3'><img src='media/data/dlink.png' alt = ''/></a><a class='plink' href='http://codecanyon.net/user/Tean/portfolio' target='_blank'><img src='media/data/url.png' alt = 'purchase'/></a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/1/Tim_McMorris_-_Be_My_Valentine.mp3' data-ogg='../media/audio/1/Tim_McMorris_-_Be_My_Valentine.ogg'><a class='playlistNonSelected' href='#'>Tim McMorris - Be My Valentine</a><a class='dlink' href='#' data-dlink='../media/audio/1/Tim_McMorris_-_Be_My_Valentine.mp3'><img src='media/data/dlink.png' alt = ''/></a><a class='plink' href='http://www.google.com' target='_blank'><img src='media/data/url.png' alt = 'purchase'/></a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/1/Tim_McMorris_-_Give_Our_Dreams_Their_Wings_To_Fly.mp3' data-ogg='../media/audio/1/Tim_McMorris_-_Give_Our_Dreams_Their_Wings_To_Fly.ogg' data-download><a class='playlistNonSelected' href='#'>Tim McMorris - Give Our Dreams Their Wings To Fly</a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/1/Tim_McMorris_-_Happy_Days_Are_Here_To_Stay.mp3' data-ogg='../media/audio/1/Tim_McMorris_-_Happy_Days_Are_Here_To_Stay.ogg'><a class='playlistNonSelected' href='#'>Tim McMorris - Happy Days Are Here To Stay</a><a class='plink' href='http://www.greensock.com' target='_blank'><img src='media/data/url.png' alt = 'purchase'/></a></li>"
];

var trackList_local2 = [
    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_A_Way_To_The_Top.mp3' data-ogg='../media/audio/2/Soundroll_-_A_Way_To_The_Top.ogg'><a class='playlistNonSelected' href='#'>Soundroll - A Way To The Top</a><a class='plink' href='http://codecanyon.net/user/Tean/portfolio' target='_blank'><img src='media/data/url.png' alt = 'purchase'/></a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_Feel_Good_Journey.mp3' data-ogg='../media/audio/2/Soundroll_-_Feel_Good_Journey.ogg'><a class='playlistNonSelected' href='#'>Soundroll - Feel Good Journey</a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_Fight_No_More.mp3' data-ogg='../media/audio/2/Soundroll_-_Fight_No_More.ogg'><a class='playlistNonSelected' href='#'>Soundroll - Fight No More</a><a class='plink' href='http://www.google.com' target='_blank'><img src='media/data/url.png' alt = 'purchase'/></a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_Funky_Boom.mp3' data-ogg='../media/audio/2/Soundroll_-_Funky_Boom.ogg'><a class='playlistNonSelected' href='#'>Soundroll - Funky Boom</a><a class='plink' href='http://codecanyon.net/user/Tean/portfolio' target='_blank'><img src='media/data/url.png' alt = 'purchase'/></a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_Pump_The_Club.mp3' data-ogg='../media/audio/2/Soundroll_-_Pump_The_Club.ogg'><a class='playlistNonSelected' href='#'>Soundroll - Pump The Club</a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_Rush.mp3' data-ogg='../media/audio/2/Soundroll_-_Rush.ogg'><a class='playlistNonSelected' href='#'>Soundroll - Rush</a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_Sun_Is_So_Bright.mp3' data-ogg='../media/audio/2/Soundroll_-_Sun_Is_So_Bright.ogg'><a class='playlistNonSelected' href='#'>Soundroll - Sun Is So Bright</a></li>"
];

var trackList_local_thumb = [
    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_A_Way_To_The_Top.mp3' data-ogg='../media/audio/2/Soundroll_-_A_Way_To_The_Top.ogg'><a class='playlistNonSelected' href='#'><span class='hap_thumb'><img src='../media/audio/2/Soundroll_-_A_Way_To_The_Top.jpg' alt=''/></span><span class='hap_title'><p>Soundroll - A Way To The Top</p></span></a></li>",

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/2/Soundroll_-_Feel_Good_Journey.mp3' data-ogg='../media/audio/2/Soundroll_-_Feel_Good_Journey.ogg'><a class='playlistNonSelected' href='#'><span class='hap_thumb'><img src='../media/audio/2/Soundroll_-_Feel_Good_Journey.jpg' alt=''/></span><span class='hap_title'><p>Soundroll - Feel Good Journey</p></span></a></li>"
];

var trackList_podcast = [
    "<li class= 'playlistItem' data-type='podcast' data-path='http://gidilounge.fm/?feed=podcast'/>",
    "<li class= 'playlistItem' data-type='podcast' data-path='http://www.kingola.com/feed/podcast/'/>"
];

var trackList_soundcloud = [
    "<li class= 'playlistItem' data-type='soundcloud' data-path='http://soundcloud.com/computer-magic'/>",
    "<li class= 'playlistItem' data-type='soundcloud' data-path='http://soundcloud.com/an21/favorites'/>"
];

var trackList_folder = [
    "<li class= 'playlistItem' data-type='folder' data-path='../media/audio/1/'/>",
    "<li class= 'playlistItem' data-type='folder' data-path='../media/audio/2/'/>"
];

var trackList_xml = [
    "<li class= 'playlistItem' data-type='xml' data-path='xml/playlist1.xml'/>",
    "<li class= 'playlistItem' data-type='xml' data-path='xml/playlist2.xml'/>"
];

var trackList_yt_single = [
    "<li class='playlistItem' data-type='youtube_single' data-path='opL4oe62XL8' ></li>",
    "<li class='playlistItem' data-type='youtube_single' data-path='Akb7SJgGx1A' ></li>",
    "<li class='playlistItem' data-type='youtube_single' data-path='uPOUgobWTT0' ></li>"
];

var trackList_yt_playlist = [
    "<li class= 'playlistItem' data-type='youtube_playlist' data-path='PLE0311B1CFA360F55'></li>"
];

var trackList_ofm_single = [
    "<li class= 'playlistItem' data-type='ofm_single' data-path='D4lw'></li>",
    "<li class= 'playlistItem' data-type='ofm_single' data-path='B1pl'></li>",
    "<li class= 'playlistItem' data-type='ofm_single' data-path='GGXE'></li>"
];

var trackList_ofm_playlist = [
    "<li class= 'playlistItem' data-type='ofm_playlist' data-path='1rp7'></li>"
];

var trackList_ofm_project = [
    "<li class= 'playlistItem' data-type='ofm_project' data-path='edB6'></li>"
];

/* database tracks in html form, but in data form in database! */
/*
 var trackList_database = [
 "<li class= 'playlistItem' data-type='database_data' data-path='ap_hap' data-table='sound'/>"
 ];
 var trackList_database2 = [
 "<li class= 'playlistItem' data-type='database_data' data-path='ap_hap' data-table='sound' data-limit='3'/>"
 ];
 var trackList_database3 = [
 "<li class= 'playlistItem' data-type='database_data' data-path='ap_hap' data-table='sound' data-range='1,5'/>"
 ];*/

/* database tracks in html form, and in html form in database! */
var trackList_database = [
    "<li class= 'playlistItem' data-type='database_html' data-path='ap_hap' data-table='sound1'/>"
];
var trackList_database2 = [
    "<li class= 'playlistItem' data-type='database_html' data-path='ap_hap' data-table='sound1' data-limit='3'/>"
];
var trackList_database3 = [
    "<li class= 'playlistItem' data-type='database_html' data-path='ap_hap' data-table='sound1' data-range='1,5'/>"
];

var trackList_mixed = [
    /*"<li class= 'playlistItem' data-type='xml' data-path='xml/playlist3.xml'/>",*/

    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.mp3' data-ogg='../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.ogg' data-thumb='../media/audio/1/_A_Bright_And_Hopeful_Future.jpg' data-dlink='local_dlink' data-download='local_global'><a class='playlistNonSelected' href='#'>Tim McMorris - A Bright And Hopeful Future</a></li>",
    "<li class= 'playlistItem' data-type='local' data-mp3='../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.mp3' data-ogg='../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.ogg' data-thumb='../media/audio/1/_A_Bright_And_Hopeful_Future.jpg' data-dlink data-download><a class='playlistNonSelected' href='#'>Tim McMorris - A Bright And Hopeful Future</a></li>",

    "<li class= 'playlistItem' data-type='podcast' data-path='http://www.npr.org/rss/podcast.php?id=510008' data-dlink='podcast_dlink' data-download='podcast_global' data-thumb='media/default_artwork/podcast/01.jpg'/>",
    "<li class= 'playlistItem' data-type='podcast' data-path='http://www.npr.org/rss/podcast.php?id=510008' data-dlink data-download data-thumb='media/default_artwork/podcast/01.jpg'/>",

    "<li class= 'playlistItem' data-type='soundcloud' data-path='http://soundcloud.com/computer-magic' data-dlink='soundcloud_dlink' data-download='soundcloud_global' data-thumb='media/default_artwork/soundcloud/01.jpg'/>",
    "<li class= 'playlistItem' data-type='soundcloud' data-path='http://soundcloud.com/computer-magic' data-dlink data-download data-thumb='media/default_artwork/soundcloud/01.jpg'/>",

    "<li class= 'playlistItem' data-type='soundcloud' data-path='http://soundcloud.com/trance/trance-single-138-bpm-anvil' data-dlink='soundcloud_dlink_NON_DW' data-download='soundcloud_global_NON_DW' data-thumb='media/default_artwork/soundcloud/01.jpg'/>",
    "<li class= 'playlistItem' data-type='soundcloud' data-path='http://soundcloud.com/trance/trance-single-138-bpm-anvil' data-dlink data-download data-thumb='media/default_artwork/soundcloud/01.jpg'/>",

    "<li class= 'playlistItem' data-type='ofm_single' data-dlink='ofm_single_dlink' data-download='ofm_single_global' data-path='B1pl' data-thumb='media/default_artwork/ofm_single/01.jpg'></li>",
    "<li class= 'playlistItem' data-type='ofm_single' data-dlink data-download data-path='B1pl' data-thumb='media/default_artwork/ofm_single/01.jpg'></li>",

    "<li class= 'playlistItem' data-type='ofm_playlist' data-dlink='ofm_playlist_dlink' data-download='ofm_playlist_global' data-path='1rp7' data-thumb='media/default_artwork/ofm_playlist/01.jpg'></li>",
    "<li class= 'playlistItem' data-type='ofm_playlist' data-dlink data-download data-path='1rp7' data-thumb='media/default_artwork/ofm_playlist/01.jpg'></li>",

    "<li class= 'playlistItem' data-type='ofm_project' data-dlink='ofm_project_dlink' data-download='ofm_project_global' data-path='edB6' data-thumb='media/default_artwork/ofm_project/01.jpg'></li>",
    "<li class= 'playlistItem' data-type='ofm_project' data-dlink data-download data-path='edB6' data-thumb='media/default_artwork/ofm_project/01.jpg'></li>",

    "<li class= 'playlistItem' data-type='youtube_single' data-dlink='youtube_single_dlink' data-download='youtube_single_global' data-path='opL4oe62XL8' data-thumb='media/default_artwork/yt_single/01.jpg'></li>",
    "<li class= 'playlistItem' data-type='youtube_single' data-dlink data-download data-path='opL4oe62XL8' data-thumb='media/default_artwork/yt_single/01.jpg'></li>",
    "<li class= 'playlistItem' data-type='youtube_playlist' data-dlink='youtube_playlist_dlink' data-download='youtube_playlist_global' data-path='PLE0311B1CFA360F55' data-thumb='media/default_artwork/yt_playlist/01.jpg'></li>",
    "<li class= 'playlistItem' data-type='youtube_playlist' data-dlink data-download data-path='PLE0311B1CFA360F55' data-thumb='media/default_artwork/yt_playlist/01.jpg'></li>"
];


/**** tracks in form of data (objects) ****/
/*
 parameters:
 required:
 type: local, podcast, soundcloud, folder, xml, youtube_single, youtube_playlist, ofm_single, ofm_playlist, ofm_project
 mp3: mp3 path to audio file (you can also use 'path' instead of 'mp3')
 optional:
 for local type:
 ogg: path to the ogg audio file, NOTE: still required if ogg is used! (not if only mp3 audio format is used)
 title: add song title
 thumb: thumbnail path
 for folder type:
 thumb: thumbnail path (otherwise it will automatically assume thumbnail with the same name as mp3 file exist in the same folder, with 'jpg' extension)
 for all types:
 thumb: backup thumbnail path (if this data type is missing a thumbnail)
 download (global download, activates global download button on active playlist item):
 - for youtube: enter download url (required!)
 - for other types: enter download url or 'true' (true will take mp3 path for download)
 dlink: (individual download, creates download icon in playlist)
 - for youtube: enter download url (required!)
 - for other types: enter download url or 'true' (true will take mp3 path for download)
 plink: Enter url (creates url icon in playlist, which links to url, target _blank)
 */

var trackList2_local1 = [
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.mp3', ogg: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.ogg', title: 'Tim McMorris - A Bright And Hopeful Future', thumb: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.jpg'},
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_Be_My_Valentine.mp3', ogg: '../media/audio/1/Tim_McMorris_-_Be_My_Valentine.ogg', title: 'Tim McMorris - Be My Valentine', thumb: '../media/audio/1/Tim_McMorris_-_Be_My_Valentine.jpg'},
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_Give_Our_Dreams_Their_Wings_To_Fly.mp3', ogg: '../media/audio/1/Tim_McMorris_-_Give_Our_Dreams_Their_Wings_To_Fly.ogg', title: 'Tim McMorris - Give Our Dreams Their Wings To Fly'},
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_Happy_Days_Are_Here_To_Stay.mp3', ogg: '../media/audio/1/Tim_McMorris_-_Happy_Days_Are_Here_To_Stay.ogg', title: 'Tim McMorris - Happy Days Are Here To Stay'},
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_Health_Happiness_Success.mp3', ogg: '../media/audio/1/Tim_McMorris_-_Health_Happiness_Success.ogg', title: 'Tim McMorris - Health Happiness Success'},
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_Marketing_Advertising_Music.mp3', ogg: '../media/audio/1/Tim_McMorris_-_Marketing_Advertising_Music.ogg', title: 'Tim McMorris - Marketing Advertising Music'},
    {type: 'local', mp3: '../media/audio/3/Bluegestalt_-_Becoming.mp3', ogg: '../media/audio/3/Bluegestalt_-_Becoming.ogg', title: 'Bluegestalt - Becoming'}
];

var trackList2_local2 = [
    {type: 'local', mp3: '../media/audio/2/Soundroll_-_Funky_Boom.mp3', ogg: '../media/audio/2/Soundroll_-_Funky_Boom.ogg', title: 'Soundroll - Funky Boom', download: "../media/audio/2/Soundroll_-_Funky_Boom.mp3", thumb: '../media/audio/2/Soundroll_-_Funky_Boom.jpg', plink:'http://www.google.com', dlink:true},
    {type: 'local', mp3: '../media/audio/2/Soundroll_-_Fight_No_More.mp3', ogg: '../media/audio/2/Soundroll_-_Fight_No_More.ogg', title: 'Soundroll - Fight No More'},
    {type: 'local', mp3: '../media/audio/2/Soundroll_-_Rush.mp3', ogg:'../media/audio/2/Soundroll_-_Rush.ogg', title: 'Soundroll - Rush'}
];

var trackList2_soundcloud = [
    {type: 'soundcloud', path: 'http://soundcloud.com/trance/trance-single-138-bpm-anvil', download: true, dlink: true, plink:'http://www.google.com'},
    {type: 'soundcloud', path: 'http://soundcloud.com/an21/favorites' }
];

var trackList2_podcast = [
    {type: 'podcast', path: 'http://www.npr.org/rss/podcast.php?id=510008', download: true},
    {type: 'podcast', path: 'http://feeds.feedburner.com/xpnmusicnotes/', plink:'http://www.google.com' },
    {type: 'podcast', path: 'http://robertkelly.libsyn.com/rss', dlink: true, plink:'http://codecanyon.net/user/Tean/portfolio'}
];

var trackList2_folder = [
    {type: 'folder', path: '../media/audio/1/', download: true},
    {type: 'folder', path: '../media/audio/2/' }
];

var trackList2_xml = [
    {type: 'xml', path: 'xml/playlist1.xml'},
    {type: 'xml', path: 'xml/playlist2.xml'}
];

var trackList2_yt_single = [
    {type: 'youtube_single', path: 'opL4oe62XL8', download: 'path/to/custom/youtube_single.extension'},
    {type: 'youtube_single', path: 'Akb7SJgGx1A', download: true, plink:'http://www.google.com'},
    {type: 'youtube_single', path: 'uPOUgobWTT0'}
];

var trackList2_yt_playlist = [
    {type: 'youtube_playlist', path: 'PLE0311B1CFA360F55', download: true}
];

var trackList2_ofm_single = [
    {type: 'ofm_single', path: 'D4lw', download: 'path/to/custom/ofm_single.extension'},
    {type: 'ofm_single', path: 'B1pl'},
    {type: 'ofm_single', path: 'GGXE', download: true}
];

var trackList2_ofm_playlist = [
    {type: 'ofm_playlist', path: '1rp7'}
];

var trackList2_ofm_project = [
    {type: 'ofm_project', path: 'edB6'}
];

/* database tracks in data form, and in data form in database! */
var trackList2_database = [
    {type: 'database_data', path: 'ap_hap', table: 'sound'}
];
var trackList2_database2 = [
    {type: 'database_data', path: 'ap_hap', table: 'sound', limit: 5}
];
var trackList2_database3 = [
    {type: 'database_data', path: 'ap_hap', table: 'sound', range: '1,4'}
];
/* database tracks in data form, but in html form in database! */
/*
 var trackList2_database = [
 {type: 'database_html', path: 'ap_hap', table: 'sound1'}
 ];
 var trackList2_database2 = [
 {type: 'database_html', path: 'ap_hap', table: 'sound1', limit: 5}
 ];
 var trackList2_database3 = [
 {type: 'database_html', path: 'ap_hap', table: 'sound1', range: '1,4'}
 ];*/

var trackList2_mixed = [
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.mp3', ogg: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.ogg', title: 'Tim McMorris - A Bright And Hopeful Future', thumb: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.jpg', dlink: 'local_dlink', download:'path/to/custom/local.extension'},
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.mp3', ogg: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.ogg', title: 'Tim McMorris - A Bright And Hopeful Future', thumb: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.jpg', dlink: true, download:true},

    {type: 'podcast', path: 'http://www.npr.org/rss/podcast.php?id=510008', dlink: 'podcast_dlink', download:'path/to/custom/podcast.extension'},
    {type: 'podcast', path: 'http://www.npr.org/rss/podcast.php?id=510008', dlink: true, download:true},

    {type: 'soundcloud', path: 'http://soundcloud.com/computer-magic', dlink: 'soundcloud_dlink', download:'path/to/custom/soundcloud.extension'},
    {type: 'soundcloud', path: 'http://soundcloud.com/computer-magic', dlink:true, download:true},

    {type: 'soundcloud', path: 'http://soundcloud.com/trance/trance-single-138-bpm-anvil', dlink: 'soundcloud_dlink_NON_DW', download:'path/to/custom/soundcloud.extension_NON_DW'},
    {type: 'soundcloud', path: 'http://soundcloud.com/trance/trance-single-138-bpm-anvil', dlink: true, download:true},

    {type: 'ofm_single', path: 'B1pl',dlink: 'ofm_single_dlink',  download:'path/to/custom/ofm_single.extension'},
    {type: 'ofm_single', path: 'B1pl',dlink: true,  download:true},

    {type: 'ofm_playlist', path: '1rp7',dlink: 'ofm_playlist_dlink',  download:'path/to/custom/ofm_playlist.extension'},
    {type: 'ofm_playlist', path: '1rp7',dlink: true,  download:true},

    {type: 'ofm_project', path: 'edB6',dlink: 'ofm_project_dlink',  download:'path/to/custom/ofm_project.extension'},
    {type: 'ofm_project', path: 'edB6',dlink: true,  download:true},

    {type: 'youtube_single', path: 'opL4oe62XL8',dlink: 'youtube_single_dlink',  download:'path/to/custom/youtube_single.extension'},
    {type: 'youtube_single', path: 'opL4oe62XL8',dlink: true,  download:true},

    {type: 'youtube_playlist', path: 'PLE0311B1CFA360F55', dlink: 'youtube_playlist_dlink', download:'path/to/custom/youtube_playlist.extension'},
    {type: 'youtube_playlist', path: 'PLE0311B1CFA360F55', dlink: true, download:true}

    /*{type: 'folder', path: '../media/audio/3/', download:'path/to/custom/folder.extension'}
     {type: 'xml', path: 'xml/playlist2.xml' }*/
];

var trackList2_mixed2 = [
    {type: 'local', mp3: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.mp3', ogg: '../media/audio/1/Tim_McMorris_-_A_Bright_And_Hopeful_Future.ogg', title: 'Tim McMorris - A Bright And Hopeful Future', download:true, dlink:'custom/path/to/download'},
    {type: 'podcast', path: 'http://www.npr.org/rss/podcast.php?id=510008', download: true, dlink:true},
    {type: 'soundcloud', path: 'http://soundcloud.com/computer-magic', download: true, dlink:true},
    {type: 'soundcloud', path: 'http://soundcloud.com/trance/trance-single-138-bpm-anvil', download: true, dlink:true},
    {type: 'youtube_single', path: 'opL4oe62XL8', download: true},
    {type: 'ofm_single', path: 'D4lw'}
];




//list of titles
var titleList = [
    'Tim McMorris - A Bright And Hopeful Future',
    'Tim McMorris - Be My Valentine',
    'Tim McMorris - Give Our Dreams Their Wings To Fly',
    'Tim McMorris - Happy Days Are Here To Stay',
    'Tim McMorris - Health Happiness Success',
    'Tim McMorris - Marketing Advertising Music',
    'Tim McMorris - Successful Business Venture'
];

var titleList2 = [
    'Soundroll - A Way To The Top',
    'Soundroll - Feel Good Journey',
    'Soundroll - Fight No More',
    'Soundroll - Funky Boom',
    'Soundroll - Pump The Club',
    'Soundroll - Rush',
    'Soundroll - Sun Is So Bright'
];

/* END TRACKS LIST FOR PLAYER API */


/* DEFAULTS */

var audio = document.createElement('audio'), mp3Support, oggSupport, html5Support=false, hap_source_path='';
if (audio.canPlayType) {
    html5Support=true;
    mp3Support = !!audio.canPlayType && "" != audio.canPlayType('audio/mpeg');
    oggSupport = !!audio.canPlayType && "" != audio.canPlayType('audio/ogg; codecs="vorbis"');
}

var isMobile = (/Android|webOS|iPhone|iPad|iPod|sony|BlackBerry/i.test(navigator.userAgent));

var isIE = false, ieBelow9 = false, ieBelow8 = false;
var ie_check = getInternetExplorerVersion();
if (ie_check != -1){
    isIE = true;
    if(ie_check < 9)ieBelow9 = true;
    if(ie_check < 8)ieBelow8 = true;
}
function getInternetExplorerVersion(){
    var rv = -1;
    if (navigator.appName == 'Microsoft Internet Explorer')
    {
        var ua = navigator.userAgent;
        var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat( RegExp.$1 );
    }
    else if (navigator.appName == 'Netscape')
    {
        var ua = navigator.userAgent;
        var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat( RegExp.$1 );
    }
    return rv;
}

/* END DEFAULTS */

/* FLASH EMBED PART (for non html5 browsers, youtube and flash audio) */

function checkFlash(dataArr, embed_circle){

    var i = 0, len = dataArr.length;

    if(!html5Support){//flash movies

        for(i;i<len;i++){

            var a_id = 'flashAudio' + i;
            var f_id = 'flashMain' + i;
            var c_id = 'circleMain' + i;

            dataArr[i].settings.flash_id = i;
            dataArr[i].settings.flashAudio = '#'+a_id;
            dataArr[i].settings.flashYoutube = '#'+f_id;
            dataArr[i].settings.circleMain = '#'+c_id;

            var flashAudioWrapper = jQuery('<div/>').addClass('flashAudio');
            var flashAudio = jQuery("<div id='"+a_id+"'><a href='http://www.adobe.com/go/getflashplayer'><img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a></div>").appendTo(flashAudioWrapper);

            var flashMainWrapper = jQuery('<div/>').addClass('flashMain');
            var flashMain = jQuery("<div id='"+f_id+"'><a href='http://www.adobe.com/go/getflashplayer'><img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a></div>").appendTo(flashMainWrapper);

            dataArr[i].holder.append(flashAudioWrapper);
            dataArr[i].holder.append(flashMainWrapper);

            if(embed_circle){
                var flashCircleWrapper = jQuery('<div/>').addClass('circleMain');
                var flashCircle = jQuery("<div id='"+c_id+"'><a href='http://www.adobe.com/go/getflashplayer'><img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player'/></a></div>").appendTo(flashCircleWrapper);
                dataArr[i].holder.find('div[class=circlePlayer]').append(flashCircleWrapper);
            }

        }
    }else{

        i = 0;
        for(i;i<len;i++){

            if(dataArr[i].settings.useOnlyMp3Format && !mp3Support){//use flash to play mp3 on browsers that do not support mp3

                var a_id = 'flashAudio' + i;

                dataArr[i].settings.flash_id = i;
                dataArr[i].settings.flashAudio = '#'+a_id;

                var flashAudioWrapper = jQuery('<div/>').addClass('flashAudio');
                var flashAudio = jQuery("<div id='"+a_id+"'><a href='http://www.adobe.com/go/getflashplayer'><img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a></div>").appendTo(flashAudioWrapper);

                dataArr[i].holder.append(flashAudioWrapper);

            }
        }
    }
}

var hap_params = {
    quality: "high",
    scale: "noscale",
    salign: "tl",
    wmode: "transparent",
    bgcolor: "#111111",
    devicefont: "false",
    allowfullscreen: "true",
    allowscriptaccess: "always"
};
function embedFlashMain(id){
    if(jQuery('.flashMain').length==0)return;
    jQuery('.flashMain').css('display','block');
    var flashvars = {},attributes = {id:id};
    swfobject.embedSWF("/bundles/core/swf/preview.swf", id, "320px", "240px", "9.0.0", "/bundles/core/swf/expressInstall.swf", flashvars, hap_params, attributes);
}
function embedFlashAudio(id){
    if(jQuery('.flashAudio').length==0)return;
    jQuery('.flashAudio').css('display','block');
    var flashvars = {},attributes = {id:id};
    swfobject.embedSWF("/bundles/core/swf/preview2.swf", id, "100px", "100px", "9.0.0", "/bundles/core/swf/expressInstall.swf", flashvars, hap_params, attributes);
}
function embedFlashCircle(id){
    if(jQuery('.circleMain').length==0)return;
    jQuery('.circleMain').css('display','block');
    var flashvars = {},attributes = {id:id};
    swfobject.embedSWF("/bundles/core/swf/circle.swf", id, "160px", "160px", "9.0.0", "/bundles/core/swf/expressInstall.swf", flashvars, hap_params, attributes);
}

//******** functions called from flash
var jsReady = false;
function isReady() {return jsReady;}

/* flash youtube callbacks */
function flashVideoEnd(data){
    if(hap_players[data.id])hap_players[data.id].flashVideoEnd();
}
function flashVideoStart(data){
    if(hap_players[data.id])hap_players[data.id].flashVideoStart();
}
function flashVideoPause(data){
    if(hap_players[data.id])hap_players[data.id].flashVideoPause();
}
function flashVideoResume(data){
    if(hap_players[data.id])hap_players[data.id].flashVideoResume();
}
function flashYoutubeData(data){
    if(hap_players[data.id])hap_players[data.id].flashYoutubeData(data.bl,data.bt,data.t,data.d);
}
/*flash audio callbacks*/
function flashAudioEnd(data){
    if(hap_players[data.id])hap_players[data.id].flashAudioEnd();
}
function flashAudioData(data){
    if(hap_players[data.id])hap_players[data.id].flashAudioData(data.bl,data.bt,data.t,data.d);
}
/*flash circle callbacks*/
function flashCircleToggle(data){
    if(hap_players[data.id])hap_players[data.id].flashCircleToggle();
}
function flashCircleOverLoader(data){
    if(hap_players[data.id])hap_players[data.id].flashCircleOverLoader(data.val);
}
function flashCircleOutLoader(data){
    if(hap_players[data.id])hap_players[data.id].flashCircleOutLoader();
}
function flashCircleSeek(data){
    if(hap_players[data.id])hap_players[data.id].flashCircleSeek(data.val);
}

/* END FLASH EMBED PART */




/* START POPUP RELATED CODE */

function notify_popup(){//called from popup window when popup window has opened!
    //console.log('notify_popup');
    if(hap_popup && hap_popup.initPopup != undefined){//dont do anything if we are not going to be able to open popup!
        if(hap_settings.autoUpdateWindowData)updatePlayerData();

        if(hap_players && hap_players[0]){
            if(hap_players[0].destroyPlaylist != undefined)hap_players[0].destroyPlaylist();
        }
        jQuery('#componentWrapper').css('display','none');//hide player in parent page (we cant clear html because we dont dynamically append componentWrapper html with jquery! Only if we save the player html prior to this action so we can reinstantiate it later.)

        try {
            if(hap_popup.initPopup != undefined)hap_popup.initPopup(hap_settings);
            if(hap_players[0])hap_players[0].find('.popup_open').css('display','none');
        }catch(e){
            alert('parent notify_popup error: ' + e.message);
            return false;
        }
    }
}

//called from popup window when popup is closed (opens player in parent window again, remove this function if you dont want this feature)
function open_player(player){
    //console.log('open_player');
    if(hap_settings.autoUpdateWindowData){
        if(player)hap_players[0] = player;//get player reference
        updatePlayerData(true);
    }
    hap_players[0] = jQuery('#componentWrapper').css('display','block').html5audio(hap_settings);//show player before init
    if(!html5Support)hap_players[0].embedFlash();
    hap_players[0].find('.popup_open').css('display','block');
}

function open_popup(url, w, h, resizable){//public api to open popup
    //console.log('open_popup');
    if(typeof(url) === 'undefined' || typeof(w) === 'undefined' || typeof(h) === 'undefined') return false;
    var cw = (window.screen.width - w) / 2, ch = (window.screen.height - h) / 2;//center popup in window

    //if popup window not already opened!
    if(!hap_popup || hap_popup.closed) {
        if(resizable){
            hap_popup=window.open(url,'hap_popup_window','menubar=no,toolbar=no,location=no,scrollbars=1,resizable,width='+w+',height='+h+',left='+cw+',top='+ch+'');
        }else{
            hap_popup=window.open(url,'hap_popup_window','menubar=no,toolbar=no,location=no,width='+w+',height='+h+',left='+cw+',top='+ch+'');
        }
        //hap_popup=window.open(url,'name','width=700,height=300');//opera doesnt want to open popup with vars in options (instead opens new tab)!
        if(!hap_popup) {
            alert("Music Player can not be opened in a popup window because your browser is blocking Pop-Ups. Please allow Pop-Ups in browser for this site to use the Music Player.");
            return false;
        }
        if (window.focus) {hap_popup.focus();}
    }else{
        //console.log('popup already opened!');
    }
    return false;
}

function updatePlayerData(isPopup){
    //console.log('updatePlayerData');
    if(!hap_players[0] || !hap_settings)return false;
    //start update settings to pass between players in popup and parent window (remove these function calls if you want to start from initail settings every time player in popup/parent is opened). This will copy last volume, whole playlist and active item.
    if(!isNaN(hap_players[0].getVolume()))hap_settings.defaultVolume = hap_players[0].getVolume();//volume
    if(!isNaN(hap_players[0].getActiveItem()))hap_settings.activeItem = hap_players[0].getActiveItem();//active item

    //console.log(hap_players[0].getVolume(), hap_players[0].getActiveItem(), hap_players[0].getMediaPlaying());

    //active playlist
    var playlistLoaded = hap_players[0].getPlaylistLoaded();
    if(playlistLoaded){
        var hidden_playlist = hap_players[0].getPlaylistHidden();
        if(!hidden_playlist){
            var playlist = hap_players[0].find('.playlist_inner').find('ul');
            if(playlist.length > 0){
                var activePlaylist = playlist.attr('id');//get id attribute
                if(isPopup && isIE){
                    var curr_playlist = jQuery(playlist.clone(true, true).wrap('<p>').parent().html());//used for popup in IE (HIERARCHY_REQUEST_ERROR)!! important!
                }else{
                    var curr_playlist = playlist.clone(true, true);
                }
                jQuery(hap_settings.playlistList).find('#'+activePlaylist).remove();//remove playlist with active id from playlist_list, we are going to paste new version inside (with the same id attribute) in case playlist content has been changed (added/removed tracks/order etc...)
                curr_playlist.appendTo(jQuery(hap_settings.playlistList));//copy current playlist into playlist_list
                hap_settings.activePlaylist = {hidden: false, id:'#'+activePlaylist};//active playlist
            }
        }else{//hidden playlist
            var playlist = hap_players[0].get_hidden_playlist_holder().children();//hidden_playlist_holder doesnt have ul node, just li nodes
            if(playlist.length > 0){
                var activePlaylist = 'playlist' + Math.floor((Math.random()*9999));//get id attribute
                var curr_playlist = jQuery('<ul id='+activePlaylist+'/>');
                if(isPopup && isIE){
                    jQuery(playlist.clone(true, true).wrap('<p>').parent().html()).appendTo(curr_playlist);//used for popup in IE (HIERARCHY_REQUEST_ERROR)!! important!
                }else{
                    playlist.clone(true, true).appendTo(curr_playlist);
                }
                if(hap_players[0].getPlaylistList()){
                    curr_playlist.appendTo(hap_players[0].getPlaylistList());//copy current playlist into playlist_list
                    hap_settings.activePlaylist = {hidden: true, id:'#'+activePlaylist};//active playlist
                    hap_players[0].get_hidden_playlist_holder().html('');//empty hidden_playlist_holder
                }
            }
        }
        var mediaPlaying = hap_players[0].getMediaPlaying();
        mediaPlaying ? hap_settings.autoPlay=true : hap_settings.autoPlay=false;
        //seek to?, cookies , remember time (double check for all media types + yt separatelly!)
    }else{
        hap_settings.activePlaylist='';
    }
    //end update settings */
}

/* END POPUP RELATED CODE */
