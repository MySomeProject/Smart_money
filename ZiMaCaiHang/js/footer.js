


$(function(){
    /*
        下载APP浮层
    */
    var _MSAPPDOWN = {
        down  : function() {
            var $btns = $( '.ms-down-btn' );
            if ( !$btns.length ) {
                return;
            }
            var __bind = function( item ) {
                if ( MS.platform.isIphone ) {
                    if( MS.platform.isWeChat ){
                        item.attr( {
                            'target' : '_blank',
                            'href'   : 'http://mp.weixin.qq.com/mp/redirect?url=https://itunes.apple.com/cn/app/min-sheng-yi-dai/id913065836?mt=8'
                        } );
                        return;
                    }else{
                        item.attr( {
                            'target' : '_blank',
                            'href'   : 'https://itunes.apple.com/cn/app/min-sheng-yi-dai/id913065836?mt=8'
                        } );
                    }
                } else if ( MS.platform.isIpad ) {
                    if( MS.platform.isWeChat ){
                        item.attr( {
                            'target' : '_blank',
                            'href'   : 'http://mp.weixin.qq.com/mp/redirect?url=https://itunes.apple.com/cn/app/min-sheng-yi-dai/id913065836?mt=8'
                        } );
                        return;
                    }else{
                        item.attr( {
                            'target' : '_blank',
                            'href'   : 'https://itunes.apple.com/cn/app/min-sheng-yi-dai/id913065836?mt=8'
                        } );
                    }
                } else if ( MS.platform.isAndroid ) {
                    if ( MS.platform.isWeChat ) {
                        item.attr( {
                            'target' : '_blank',
                            'href'   : 'http://a.app.qq.com/o/simple.jsp?pkgname=com.msyd.client'
                        } );
                        return;
                    }else{
                        item.attr( 'href', 'http://static.msyidai.com/m/android/msyd.apk' );
                    }
                }else{
                    item.attr( {
                        'target' : '_blank',
                        'href'   : 'http://www.msyidai.com/appBeOnline'
                    } );
                }
            };
            $.each( $btns, function( index, item ) {
                __bind( $( item ) );
            } );
        },
        close : function() {
            var $closeBtn = $( '#i_close' );
            var $ms_app_layer = $( '#ms_app_layer' );
            if ( !$closeBtn.length || !$ms_app_layer.length ) {
                return;
            }
            $closeBtn.on( "click", function( e ) {
                e.preventDefault();
                e.stopPropagation();
                $ms_app_layer.hide();
                return false;
            } );
        },
        init  : function() {
            this.close();
            this.down();
        }
    };
    _MSAPPDOWN.init();
    function hideDownApp(){
        $( '.ms-app-layout' ).animate( {
            opacity : 0,
            height : 0
        }, 200, 'ease-out' );
    }
    function showDownApp(){
        $( '.ms-app-layout' ).animate( {
            opacity : 0.85,
            height : 60
        }, 200, 'ease-out' );
    }
    $( 'input' ).off( 'focus', hideDownApp ).on( 'focus', hideDownApp );
    $( 'input' ).off( 'blur', showDownApp ).on( 'blur', showDownApp );
    /*
        返回顶部
    */
    var $t = $( '#goTop' );
    var $h = 320;
    if ( !$t.length ) {
        return;
    }
    var handler = function( e ) {
        e.preventDefault();
        e.stopPropagation();
        var $target = e.target;
        var $id = $( $target ).attr( 'id' );
        if ( $id === 'goTop' ) {
            $( window ).scrollTop( 0 );
            return false;
        }
    };
    var __init = function( e ) {
        if ( $( window ).scrollTop() > $h ) {
            $( $t ).css( 'visibility', 'visible' );
        } else {
            $( $t ).css( 'visibility', 'hidden' );
        }
    };
    __init();
    $( window ).off( 'scroll', __init ).on( 'scroll', __init );
    $t.off( 'click', handler ).on( 'click', handler );
});