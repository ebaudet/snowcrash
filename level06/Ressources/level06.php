#!/usr/bin/php
<?php
/**
 * Function y change the . to x and @ to y;
 * "test@mail.com" => "test x mail ycom"
 *  - $m entry string (with @ and .)
 *  Return:
 *    string without @ and .
 */
function y($m)
{
    $m = preg_replace("/\./", " x ", $m);
    $m = preg_replace("/@/", " y", $m);
    return $m;
}

/**
 * Get list of mails in file
 * args :
 *  - $y : name of file
 *  - $z : useless variable.
 */
function x($y, $z)
{
    $a = file_get_contents($y);
    // take string like [x text_to_test] and call y function as
    // y("text_to_test")
    $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
    // replace "[" by "("
    $a = preg_replace("/\[/", "(", $a);
    // replace "]" by ")"
    $a = preg_replace("/\]/", ")", $a);
    return $a;
}

$r = x($argv[1], $argv[2]);

print $r;
?>
