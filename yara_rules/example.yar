rule Example_EICAR
{
    strings:
        $eicar = "X5O!P%@AP[4\\PZX54(P^)7CC)7}$" ascii
        $eicar_eval = "eval("
    condition:
        $eicar
}