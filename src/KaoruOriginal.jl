module KaoruOriginal
# Write your package code here.

    export showtable, makevisible, for_plotting, custom_sort, show_html_df, table_func

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
        export  kaoruoriginalhello, hover_info
        using DataFrames

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

    module table_func
    export add_colorname_col, row_color_change, count_str, get_colvalue_max_width_list, get_colname_width_list, get_max_width_list

        # colorというcolを追加
        function add_colorname_col(
            df,
            middlle_c="rgb(239, 243, 255)",
            bottom_c="rgb(189, 215, 231)"
        )
            tmpdf = copy(df)
            tmpdf.color .= middlle_c
            tmpdf[end, :color] = bottom_c
            return tmpdf
        end

        # 特定の行の色の行を変更する関数
        function row_color_change(
            df
            , color_specify_dict # keyにインデックス名，valueに色
            , color_col=:color
        )
            for (k, v) in color_specify_dict
                df[k, color_col] = v
            end

            return df
        end

        # <br>タグを除い文字列の数を返す関数
        function count_str(str)
            return maximum(length.(split(str, "<br>")))
        end

        # カラムのvalueのmax幅を出すリスト
        function get_colvalue_max_width_list(df; normalize = false)
            max_width_list = []
            for col in eachcol(df)
                push!(max_width_list, maximum([length(string(x)) for x in col]))
            end

            if normalize
                max_width_list = max_width_list ./ sum(max_width_list)
            end

            return max_width_list
        end

        # カラム名の文字数を取得する関数
        function get_colname_width_list(df; normalize = false)
            colname_width_list = []
            for colname in names(df)
                push!(colname_width_list, count_str(colname))
            end

            if normalize
                colname_width_list = colname_width_list ./ sum(colname_width_list)
            end

            return colname_width_list
        end

        # カラムごとのmax幅を出すリスト
        function get_max_width_list(df; normalize = false)
            max_width_list = []
            for colname in names(df)
                value_max = maximum([length(string(x)) for x in df[!,colname]])
                colname_max = count_str(colname)
                push!(max_width_list, maximum([value_max, colname_max]))
            end

            if normalize
                max_width_list = max_width_list ./ sum(max_width_list)
            end

            return max_width_list
        end
    end
end
