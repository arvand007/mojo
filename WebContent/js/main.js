/* ==========================================================================
    Collapse
 ========================================================================== */
$(document).ready(function () {
    $(".sidebar-toggle").click(function () {
        $(".main-header").toggleClass("collapse");
        $(".main-sidebar").toggleClass("collapse");
        $(".content-wrapper").toggleClass("collapse");
    });
});