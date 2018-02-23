struct TreePath{V, E}
    source::V
    target::V
    edges::Vector{E} # in order
    directions::Vector{Symbol} # Symbol: :up if going from source to LCA, :down if going from LCA to target
    indexmap::SparseVector{Int}
end

source(path::TreePath) = path.source
target(path::TreePath) = path.target

path_edge_index(edge::E, path::TreePath{<:Any, E}) where {E} = path.indexmap[edge_index(edge)]
Base.in(edge::E, path::TreePath{<:Any, E}) where {E} = path_edge_index(edge, path) != 0
direction(edge::E, path::TreePath{<:Any, E}) where {E} = path.directions[path_edge_index(edge, path)]

Base.start(path::TreePath) = start(path.edges)
Base.next(path::TreePath, state) = next(path.edges, state)
Base.done(path::TreePath, state) = done(path.edges, state)
Base.eltype(path::TreePath) = eltype(path.edges)
Base.length(path::TreePath) = length(path.edges)
# Base.size(path::TreePath) = size(path.edges)
# Base.last(path::TreePath) = last(path.edges)

function Base.show(io::IO, path::TreePath)
    println(io, "Path from $(path.source) to $(path.target):")
    for edge in path
        directionchar = ifelse(direction(edge, path) == :up, '↑', '↓')
        print(io, "$directionchar ")
        showcompact(io, edge)
        println(io)
    end
end

function TreePath(src::V, target::V, tree::SpanningTree{V, E}) where {V, E}
    source_to_lca = E[]
    lca_to_target = E[]
    source_current = src
    target_current = target
    while source_current != target_current
        if tree_index(source_current, tree) > tree_index(target_current, tree)
            edge = edge_to_parent(source_current, tree)
            push!(source_to_lca, edge)
            source_current = source(edge, tree)
        else
            edge = edge_to_parent(target_current, tree)
            push!(lca_to_target, edge)
            target_current = source(edge, tree)
        end
    end
    reverse!(lca_to_target)

    edges = collect(E, flatten((source_to_lca, lca_to_target)))
    directions = collect(Symbol, flatten(((:up for e in source_to_lca), (:down for e in lca_to_target))))
    indexmap = sparsevec(Dict(edge_index(e) => i for (i, e) in enumerate(edges)), num_edges(tree))
    TreePath{V, E}(src, target, edges, directions, indexmap)
end