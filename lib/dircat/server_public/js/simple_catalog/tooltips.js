$(function() {
    var hideDelay = 500;
    var item_id;
    var hideTimer = null;

    var str_selector = '.popup_items a';
    var str_popup = 'popup';

    // One instance that's reused to show info
    var container = $(
            '<div id="'+ str_popup + '">'
                    + '<table width="" border="0" cellspacing="0" cellpadding="0" align="center">'
                    + '<tr>'
                    + '   <td class="corner topLeft"></td>'
                    + '   <td class="top"></td>'
                    + '   <td class="corner topRight"></td>'
                    + '</tr>'
                    + '<tr>'
                    + '   <td class="left">&nbsp;</td>'
                    + '   <td><div class="content"></div></td>'
                    + '   <td class="right">&nbsp;</td>'
                    + '</tr>'
                    + '<tr>'
                    + '   <td class="corner bottomLeft">&nbsp;</td>'
                    + '   <td class="bottom">&nbsp;</td>'
                    + '   <td class="corner bottomRight"></td>'
                    + '</tr>'
                    + '</table>'
                    + '</div>');

    $('body').append(container);

    $(str_selector).live('mouseover', function() {
        var item_id = $(this).attr('rel');
        if (item_id == '') {
            return;
        }
        if (hideTimer) {
            clearTimeout(hideTimer);
        }

        var pos = $(this).offset();
        var width = $(this).width();
        container.css({
            left: (pos.left + width) + 'px',
            top: pos.top - 5 + 'px'
        });

        $('#' + str_popup + ' .content').html('&nbsp;');

        $.ajax({
            type: 'GET',
            url: 'ajax/ajax_item/' + item_id,
            // data: '',
            success: function(data) {
                // Verify requested person is this person since we could have multiple ajax
                // requests out if the server is taking a while.
                // if (data.indexOf(currentID) < 0) {}
                // var text = $(data).find('film_popup').html();
                $('#' + str_popup + ' .content').html(data)
                $('#' + str_popup + " img").aeImageResize({height: 200, width: 250});
                container.css('display', 'block');
            }
        });

    });

//    $(str_selector).live('mouseout', function() {
//        if (hideTimer) {
//            clearTimeout(hideTimer);
//        }
//        hideTimer = setTimeout(function() {
//            container.css('display', 'none');
//        }, hideDelay);
//    });
//
//    // Allow mouse over of details without hiding details
//    $('#popup').mouseover(function() {
//        if (hideTimer) {
//            clearTimeout(hideTimer);
//        }
//    });
//
//    // Hide after mouseout
//    $('#popup').mouseout(function() {
//        if (hideTimer) {
//            clearTimeout(hideTimer);
//        }
//        hideTimer = setTimeout(function() {
//            container.css('display', 'none');
//        }, hideDelay);
//    });
});
