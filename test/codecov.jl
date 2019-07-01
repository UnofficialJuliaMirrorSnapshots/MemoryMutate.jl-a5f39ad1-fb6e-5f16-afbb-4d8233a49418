# need to run
#  julia --code-coverage=user runtest.jl
# within the `test` directory

println(pwd())
cd(joinpath("$(@__DIR__)",".."))
println(pwd())

using Coverage
# process '*.cov' files
coverage = process_folder() # defaults to src/; alternatively, supply the folder name as argument
# coverage = append!(coverage, process_folder("deps"))
# process '*.info' files
coverage = merge_coverage_counts(coverage, filter!(
    let prefixes = (joinpath(pwd(), "src", ""),)
                    # joinpath(pwd(), "deps", ""))
        c -> any(p -> startswith(c.filename, p), prefixes)
    end,
    LCOV.readfolder("test")))
# Get total coverage for all Julia files
covered_lines, total_lines = get_summary(coverage)
# Or process a single file
@show get_summary(process_file(joinpath("src", "MemoryMutate.jl")))
