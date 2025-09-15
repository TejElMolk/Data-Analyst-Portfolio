let
    // Left table (user order frequency data)
    LeftTable = User_Average_Order_Frequency,

    // Right table (all customers data)
    RightTable = #"all customers",

    // Join the two tables on user_id and user_unique_id
    Joined = Table.Join(
        LeftTable,
        "user_id",
        RightTable,
        "user_unique_id",
        JoinKind.LeftOuter
    ),

    // Add customer category column based on number of orders
    #"Added Customer Category" = Table.AddColumn(
        Joined,
        "Customer_Category",
        each if [Number_of_Orders] = 1 then "Occasional (1 order)"
             else if [Number_of_Orders] = 2 then "Recurrent (2 orders)"
             else "Loyal (+3 orders)"
    ),

    // Add column for order frequency bins, but only if there is more than 1 order
    #"Added Order Frequency Bin" = Table.AddColumn(
        #"Added Customer Category",
        "Order_Frequency_Bin",
        each
            if [Number_of_Orders] = 1 or [Avg_days_between_orders] = null then null
            else
                let days = [Avg_days_between_orders]
                in if days <= 30 then "0-1 month"
                else if days <= 60 then "2 months"
                else if days <= 90 then "3 months"
                else if days <= 120 then "4 months"
                else if days <= 180 then "5-6 months"
                else if days <= 270 then "7-9 months"
                else "10-11 months"
    ),

    // Add BasketSegment column based on Average_Order_Amount
    AverageBasketValue = 239.55,
    #"Added BasketSegment" = Table.AddColumn(
        #"Added Order Frequency Bin",
        "BasketSegment",
        each if [Average_Order_Amount] < AverageBasketValue * 0.75 then "Small Basket"
             else if [Average_Order_Amount] <= AverageBasketValue * 1.25 then "Average Basket"
             else "Large Basket",
        type text
    ),

    // Join Favorite Category table by user_id_unique
    #"Joined Favorite Category" = Table.Join(
        #"Added BasketSegment",
        "user_id",
        Favorite_Category,
        "user_id_unique",
        JoinKind.LeftOuter
    )

in
    #"Joined Favorite Category"
