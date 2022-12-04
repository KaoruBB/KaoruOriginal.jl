module KaoruOriginal
# Write your package code here.

    export showtable, makevisible, datascience

    using DataFrames

    function showtable(df)
        DataFrame([[names(df)];
            [eltype.(eachcol(df))];
            collect.(eachrow(df))], [:column; :dtypes; Symbol.(axes(df, 1))])
    end


    function makevisible()
       Base.text_colors[:light_black] = Base.text_colors[:light_green]
    end

    # function change_col_colors(; kwargs...)
    #     print(kwargs)
    #     prinln(typeof(kwargs))
    #     if not "header_crayon" in kwargs
    #         kwargs.append(( "header_crayon" => :white )
    #     end
    #     if "subheader_crayon" is not in kwargs
    #         kwargs.append(( "subheader_crayon" => :white ))
    #     end
    #     Base.display(df::AbstractDataFrame) = show(
    #         df,
    #         kwargs...
    #     )
    # end

    module datascience
        export  kaoruoriginalhello

    function kaoruoriginalhello(x)
            println("Hello, $x")
    end

end

end
