module KaoruOriginal
# Write your package code here.

    export showtable, makevisible, for_plotting, custom_sort, show_html_df

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


    module for_plotting
        export  kaoruoriginalhello

    function kaoruoriginalhello(x)
            println("Hello, $x")
    end

    """
        hover_info(df::AbstractDataFrame, pair_list::Vector{Pair{Symbol, String}})

    Return a vector of hover text.


    # Examples

    ```jldoctest
    julia> df = DataFrame(
        index=1:4,
        name=["John", "Sally", "Kirk", "John"],
        apple=[2, 4, 5, 6],
        banana=[3,5,2,0]
    )


    julia> symbols_labels = [
            :name => "名前",
            :apple => "りんご",
            :banana => "バナナ"
        ]
    3-element Vector{Pair{Symbol, String}}:
    :name => "名前"
    :apple => "りんご"
    :banana => "バナナ"


    julia> hover_info(df, symbols_labels)
    4-element Vector{String}:
    "名前: John<br>りんご: 2<br>バナナ: 3"
    "名前: Sally<br>りんご: 4<br>バナナ: 5"
    "名前: Kirk<br>りんご: 5<br>バナナ: 2"
    "名前: John<br>りんご: 6<br>バナナ: 0"
    ```
    """
    function hover_info(df, pair_list)
        return [
            join([name * ": " * string(df[i, col]) for (col, name) in pair_list], "<br>") for i in 1:nrow(df)
        ]
    end


end

end
