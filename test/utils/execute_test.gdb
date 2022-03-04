target remote :1234
break reporting__reportsuccess
commands 1
    print "Success"
    quit
end
break reporting__reporterror
commands 2
    print "Error"
    quit
end
c
