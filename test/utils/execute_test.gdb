target remote :1234
break reporting__reportsuccess
commands 1
    print "Success"
    quit
end
break reporting__reporterror
commands 2
    print "Error: incorrect result"
    quit
end
break Dummy_Handler
commands 3
    print "Error: trap handler"
    quit
end
c
