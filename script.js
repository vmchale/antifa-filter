var ELEMENT = 1;
var DOCUMENT = 9;
var DOCUMENT_FRAGMENT = 11;
var TEXT = 3;

var MATCH = ['mike pence','donald trump','trump','paul ryan','reince priebus']; 
//,'reince priebus','mike pence'];
var REPLACE = ['I torture gays','pétain with the taped tie','rapist pig','Judas Iscariot','Gollum Franco'];
//,'Gollum Franco','I torture gays']; 

walk(document.body);

function walk(node) {

    var child, next;

    switch (node.nodeType) {
        case ELEMENT:  // Element
        case DOCUMENT:  // Document
        case DOCUMENT_FRAGMENT: // Document fragment
            child = node.firstChild;
            while (child) {
                next = child.nextSibling;
                walk(child);
                child = next;
            }
            break;

        case TEXT: // Text node
            replaceText(node);
            break;
    }
}

function replaceText(textNode) {
    var v = textNode.nodeValue;

    // Go through and match/replace all the strings we've given it, using RegExp.
    for (var i = 0; i < MATCH.length; i++) {
        v = v.replace(new RegExp(MATCH[i], 'gi'), REPLACE[i]);
    }

    textNode.nodeValue = v;
}
