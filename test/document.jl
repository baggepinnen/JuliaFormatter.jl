@testset "Document" begin
    @testset "count unicode literals in bytes" begin
        s = """
        \"""
        𝔽𝔽

        \"""
        struct A end
        """
        d = JuliaFormatter.Document(s)
        ranges = Dict(1 => 1:3, 2 => 4:6, 3 => 7:7, 4 => 8:12, 5 => 13:25, 6 => 26:25)
        @test ranges == d.line_to_range
    end

    @testset "count unicode whitespace in bytes" begin
        s0 = """a = b || c ;
               f("A")"""
        d = JuliaFormatter.Document(s0)
        ranges = Dict(1 => 1:13, 2 => 14:19)
        @test ranges == d.line_to_range

        # this string has a nbsp after 'c'
        # so it should have an additional byte because
        # it's unicode
        s = """a = b || c ;
               f("A")"""
        d = JuliaFormatter.Document(s)
        ranges = Dict(1 => 1:14, 2 => 15:20)
        @test ranges == d.line_to_range
    end
end
