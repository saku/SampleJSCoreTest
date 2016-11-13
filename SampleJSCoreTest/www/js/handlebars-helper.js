/*!

 handlebars helper

Copyright (C) 2016 by Yoichiro Sakurai

*/

function registerHelpersAndPartials() {
	// {{#ifCond unicorns "<" ponies }}
	// 	I knew it, unicorns are just low-quality ponies!
	// {{/ifCond}}
	Handlebars.registerHelper('ifCond', function(lvalue, operator, rvalue, options) {
        if (arguments.length < 4) {
            throw new Error("Handlerbars Helper 'ifCond' needs 3 parameters");
        }

        // validate value, if values is undefined then convert 0.
        if (operator != 'typeof') {
            if (typeof lvalue == 'undefined') lvalue = 0;
            if (typeof rvalue == 'undefined') rvalue = 0;
        }

        var operators = {
            '==':		function(l,r) { return l == r; },
            '===':		function(l,r) { return l === r; },
            '!=':		function(l,r) { return l != r; },
            '<':		function(l,r) { return l < r; },
            '>':		function(l,r) { return l > r; },
            '<=':		function(l,r) { return l <= r; },
            '>=':		function(l,r) { return l >= r; },
            '||':		function(l,r) { return l || r; },
            '&&':		function(l,r) { return l && r; },
            'typeof':	function(l,r) { return typeof l == r; }
        }

        if (!operators[operator])
            throw new Error("Handlerbars Helper 'ifCond' doesn't know the operator "+operator);
                              
        var result = operators[operator](lvalue,rvalue);
        if( result ) {
            return options.fn(this);
        } else {
            return options.inverse(this);
        }
    });
}

registerHelpersAndPartials();
