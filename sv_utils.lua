QT.RegisterCallback("gg-rent:HasEnough", function(source, cb, price)
    local moneyItem = QT.HasItem(source, Shared.MoneyItem, price)
    if moneyItem then 
        cb(true)
        QT.RemoveItem(source, Shared.MoneyItem, price)
    else
        cb(false)
    end
end)