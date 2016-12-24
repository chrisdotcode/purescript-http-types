'use strict';

function statusCodeFromStringImpl(just) {
	return function(nothing) {
	return function(StatusCode) {
	return function(reasonPhraseFromString) {
	return function(str) {
		// XXX In RFC 2616 section 6.1, the regex is a bit looser than
		// this for the Reason Phrase, but this should suffice for what
		// I presume will be ~99% of cases.
		var regex = /^(\d\d\d) ([\w ]*)$/;

		var results = str.match(regex);

		if (results && results.length == 3) {
			return just(StatusCode({
				code: results[1],
				reasonPhrase: reasonPhraseFromString(results[2])
			}));
		} else {
			return nothing();
		}
	}}}}
}

exports.statusCodeFromStringImpl = statusCodeFromStringImpl;
