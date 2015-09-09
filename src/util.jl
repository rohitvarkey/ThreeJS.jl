# Dict macro
macro d(xs...)
  if VERSION < v"0.4-"
    Expr(:dict, map(esc, xs)...)
  else
    :(Dict($(map(esc, xs)...)))
  end
end
