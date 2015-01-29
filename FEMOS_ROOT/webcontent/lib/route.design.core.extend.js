Kinetic.Curve = function(config) {
    this.setDefaultAttrs({
        points: [],
        lineCap: 'butt',
        detectionType: 'pixel'
    });

    this.shapeType = "Curve";
    config.drawFunc = function() {
        var context = this.getContext();
        var lastPos = {};

        //
        var x1 = this.attrs.points[0].x;
        var y1 = this.attrs.points[0].y;
        
        var cpx = this.attrs.points[1].x;
        var cpy = this.attrs.points[1].y;

        var x2 = this.attrs.points[2].x;
        var y2 = this.attrs.points[2].y;

   		
        context.beginPath();
        context.moveTo(x1,y1);		
        context.quadraticCurveTo(cpx,cpy,x2,y2);

        if(!!this.attrs.lineCap) {
            context.lineCap = this.attrs.lineCap;
        }

        this.stroke();
    };
    // call super constructor
    Kinetic.Shape.apply(this, [config]);
};
/*
 * Curve methods
 */
Kinetic.Curve.prototype = {
    setPoints: function(points) {
        this.setAttrs({
            points: points
        });
}};

// extend Shape
Kinetic.GlobalObject.extend(Kinetic.Curve, Kinetic.Shape);
// add setters and getters
Kinetic.GlobalObject.addSetters(Kinetic.Curve, ['lineCap']);
Kinetic.GlobalObject.addGetters(Kinetic.Curve, ['lineCap', 'points']);
