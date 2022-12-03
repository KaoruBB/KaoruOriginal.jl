module KaoruOriginal
# Write your package code here.

export showtable, datascience

using DataFrames

function showtable(df)
    DataFrame([[names(df)];
		   [eltype.(eachcol(df))];
		   collect.(eachrow(df))], [:column; :dtypes; Symbol.(axes(df, 1))])
end

Base.display(df::AbstractDataFrame) = show(
	df, header_crayon = DataFrames.crayon"light_green"
	, subheader_crayon = DataFrames.crayon"white"
)

module datascience
export  kaoruoriginalhello

function kaoruoriginalhello(x)
    println("Hello, $x")
end

end


end
