package com.responsive
{
    import flash.events.Event;
    import mx.core.UIComponent;
    import mx.events.FlexEvent;
    import spark.components.Group;

    /**
     * A screen-filling adapter for the existing 1280x720/1290x720
     * absolute-positioned pages. Does NOT modify any view's data or events.
     *
     * fitMode = fill (default): use all available space in landscape,
     *   including wider-than-16:9 phones. Text and images may stretch.
     * fitMode = contain: preserve aspect, but leave side/top bands.
     * fitMode = cover: preserve aspect and fill, but clips edge controls.
     *
     * protectPortrait = true (default) disables nonuniform stretching in
     * portrait. Portrait-safe reflow requires rebuilding each legacy canvas.
     */
    public class ResponsiveStage extends Group
    {
        private var _designWidth:Number = 1280;
        private var _designHeight:Number = 720;
        private var _fitMode:String = "fill";
        private var _protectPortrait:Boolean = true;
        private var activeParent:UIComponent;
        private var fitQueued:Boolean = false;

        public function ResponsiveStage()
        {
            super();
            includeInLayout = false;
            addEventListener(Event.ADDED_TO_STAGE, onAdded, false, 0, true);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemoved, false, 0, true);
            addEventListener(FlexEvent.CREATION_COMPLETE, onCreated, false, 0, true);
        }

        [Inspectable]
        public function get designWidth():Number { return _designWidth; }
        public function set designWidth(value:Number):void
        {
            if (value <= 0 || isNaN(value)) return;
            _designWidth = value;
            width = value;
            requestFit();
        }

        [Inspectable]
        public function get designHeight():Number { return _designHeight; }
        public function set designHeight(value:Number):void
        {
            if (value <= 0 || isNaN(value)) return;
            _designHeight = value;
            height = value;
            requestFit();
        }

        [Inspectable(enumeration="fill,contain,cover",defaultValue="fill")]
        public function get fitMode():String { return _fitMode; }
        public function set fitMode(value:String):void
        {
            if (value != "fill" && value != "contain" && value != "cover") return;
            _fitMode = value;
            requestFit();
        }

        [Inspectable(defaultValue="true")]
        public function get protectPortrait():Boolean { return _protectPortrait; }
        public function set protectPortrait(value:Boolean):void
        {
            _protectPortrait = value;
            requestFit();
        }

        private function onCreated(event:FlexEvent):void { requestFit(); }
        private function onAdded(event:Event):void
        {
            if (activeParent != null)
                activeParent.removeEventListener(Event.RESIZE, parentResized);
            activeParent = parent as UIComponent;
            if (activeParent != null)
                activeParent.addEventListener(Event.RESIZE, parentResized, false, 0, true);
            requestFit();
        }
        private function onRemoved(event:Event):void
        {
            if (activeParent != null)
                activeParent.removeEventListener(Event.RESIZE, parentResized);
            activeParent = null;
        }
        private function parentResized(event:Event):void { requestFit(); }
        private function requestFit():void
        {
            if (fitQueued) return;
            fitQueued = true;
            callLater(fitToParent);
        }

        private function fitToParent():void
        {
            fitQueued = false;
            if (parent == null || _designWidth <= 0 || _designHeight <= 0) return;
            var pw:Number = parent.width;
            var ph:Number = parent.height;
            if (isNaN(pw) || isNaN(ph) || pw <= 0 || ph <= 0) return;

            // MXML width/height remain the design dimensions; only scale changes.
            var sx:Number = pw / _designWidth;
            var sy:Number = ph / _designHeight;
            var effectiveMode:String = _fitMode;
            if (_protectPortrait && ph > pw && effectiveMode == "fill")
                effectiveMode = "contain";

            if (effectiveMode == "contain" || effectiveMode == "cover")
            {
                var uniform:Number = (effectiveMode == "cover")
                    ? Math.max(sx, sy) : Math.min(sx, sy);
                sx = uniform;
                sy = uniform;
            }
            scaleX = sx;
            scaleY = sy;
            x = Math.round((pw - _designWidth * sx) / 2);
            y = Math.round((ph - _designHeight * sy) / 2);
        }
    }
}
