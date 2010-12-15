// $Id: $
/******************************************************************************/
function date_select_today(id_prefix)
{
    var now = new Date;

    $(id_prefix + '_month').selectedIndex = now.getMonth() + 1;
    $(id_prefix + '_day').selectedIndex = now.getDate();

    var year = now.getFullYear();
    var year_index = year - (year - 2);
    $(id_prefix + '_year').selectedIndex = year_index + 1;
}
/******************************************************************************/
function date_select_none(id_prefix)
{
    $(id_prefix + '_month').selectedIndex = 0;
    $(id_prefix + '_day').selectedIndex   = 0;
    $(id_prefix + '_year').selectedIndex  = 0;
}