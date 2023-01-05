module KaoruOriginal
# Write your package code here.

    export showtable, makevisible, datascience, custom_sort, show_html_df

    using DataFrames
    using Crayons
    using BrowseTables

    function showtable(df)
        DataFrame([[names(df)];
            [eltype.(eachcol(df))];
            collect.(eachrow(df))], [:column; :dtypes; Symbol.(axes(df, 1))])
    end


    function makevisible(color="light_green")
        Base.text_colors[:light_black] = Base.text_colors[:light_green]
        x = """ Base.display(df::AbstractDataFrame) = show(
            df, subheader_crayon = DataFrames.crayon"$(color)"
        )
        """
        x = Meta.parse(x)
        eval(x)
    end

    function custom_sort(categories)
        ordering = Dict((j, i) for (i,j) in enumerate(categories))
        return function (x, y)
            ordering[x] < ordering[y]
        end
    end

    function show_html_df(df)
        if nrow(df) < 1000
            open_html_table(df)
        else
            let
                tmp = copy(df)
                cols = names(tmp)
                tmp.index = 1:nrow(tmp)
                open_html_table(
                    vcat(tmp[1:25, ["index", cols...]], tmp[end-25:end, ["index", cols...]])
                )
            end
        end
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
