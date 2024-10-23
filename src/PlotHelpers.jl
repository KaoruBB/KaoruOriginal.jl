module PlotHelpers

using DataFrames

export
    kaoruoriginalhello,
    hover_info

function kaoruoriginalhello(x)
    "Hello, $x"
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
