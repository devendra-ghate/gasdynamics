### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ a178c59a-015d-11eb-34fa-bf8874f5b724
using Plots, PlutoUI, LaTeXStrings

# ╔═╡ b0fba9a6-0160-11eb-101b-331e454e74e7
plotly()

# ╔═╡ 92f4b804-0164-11eb-2100-9bb8a1235639
begin
	γ = [1.66, 1.4, 1.2]
end

# ╔═╡ 27d20a3c-0172-11eb-155f-cfa1bbf70998
md"## Can we have subsonic $M_1$?"

# ╔═╡ 19556266-015d-11eb-0d66-7d868991e6f1
function ΔsbyR(M₁, γ)
	γ/(γ-1)*log( 1 + (2*( (γ-1)/(γ+1)^2 ) )*( (γ*M₁^2 + 1)/M₁^2 )*( M₁^2 -1 ) ) - log( 1 + 2γ/(γ+1)*(M₁^2 -1) )
end

# ╔═╡ e21a53ec-0161-11eb-14ff-41b6c69990a6
begin
	M₁min1 = 0.4; M₁max1 = 5
	plot(M₁->ΔsbyR(M₁, γ[1]), M₁min1, M₁max1,
    	      xlabel="M₁",
              ylabel="ΔsbyR", 
              label="γ = $(γ[1])",
              title="Entropy change across a shock",
              titlefontsize=10)
	plot!(M₁->ΔsbyR(M₁, γ[2]), M₁min1, M₁max1,
				label="γ = $(γ[2])")
	plot!(M₁->ΔsbyR(M₁, γ[3]), M₁min1, M₁max1,
				label="γ = $(γ[3])")
end

# ╔═╡ f189424a-0171-11eb-1a1b-6fc1a3d7b689
md"## What is the asymptotic $M_2$ as $M_1 → ∞$?"

# ╔═╡ 0b7b26c4-0164-11eb-3d2c-2976a7baaddb
function M₂(M₁, γ)
	sqrt( (1 + (γ-1)/2*M₁^2)/(γ*M₁^2 - (γ-1)/2) )
end

# ╔═╡ 41b05b2e-0164-11eb-06a3-b32dec7dda7e
begin
	M₁min2 = 1; M₁max2 = 10
	plot(M₁->M₂(M₁, γ[1]), M₁min2, M₁max2,
    	      xlabel="M₁",
              ylabel="M₂", 
              label="γ = $(γ[1])",
              title="Mach change across a shock",
		      #annotate = (5,0.5,text("γ ")),
              titlefontsize=10)
	plot!(M₁->M₂(M₁, γ[2]), M₁min2, M₁max2,
				label="γ = $(γ[2])")
	plot!(M₁->M₂(M₁, γ[3]), M₁min2, M₁max2,
				label="γ = $(γ[3])")
end

# ╔═╡ 418465d8-0172-11eb-3b6e-513f3f29f3d4
md"## Variation of various properties with $M_1$ for $γ = 1.4$"

# ╔═╡ 5907788a-0172-11eb-29e9-a1b9e20e7f24
function T₂byT₁(M₁, γ)
	(1 + (γ-1)/2*M₁^2)/(1 + (γ-1)/2*M₂(M₁,γ)^2)
	#1 + ( 2*(γ-1)/(γ+!)^2 )*( (γ*M₁^2 + 1)*(M₁^2-1)/M₁^2 )
end

# ╔═╡ 4d8151ba-017d-11eb-3163-8db2ad5cf48c
begin
	plot(M₁->T₂byT₁(M₁, γ[2]), M₁min2, M₁max2,
    	      xlabel="M₁",
              ylabel="T₂byT₁", 
              label="γ = $(γ[2])",
              title="Static Temperature variation",
              titlefontsize=10)
	plot!(M₁->T₂byT₁(M₁, γ[1]), M₁min2, M₁max2,
				label="γ = $(γ[1])")
end

# ╔═╡ b123104c-0172-11eb-1043-07aad280cce1
function p₂byp₁(M₁, γ)
	(1 + γ*M₁^2)/(1 + γ*M₂(M₁,γ)^2)
end

# ╔═╡ 7afea4a8-0173-11eb-2132-517203f1f9ed
begin
	plot(M₁->p₂byp₁(M₁, γ[2]), M₁min2, M₁max2,
    	      xlabel="M₁",
              ylabel="p₂byp₁", 
              label="γ = $(γ[2])",
              title="Pressure variation",
              titlefontsize=10)
	plot!(M₁->p₂byp₁(M₁, γ[1]), M₁min2, M₁max2,
		label="γ = $(γ[1])")
end

# ╔═╡ 4b9c4e18-0173-11eb-1abe-0905574fc87d
function ρ₂byρ₁(M₁, γ)
	p₂byp₁(M₁, γ)/T₂byT₁(M₁, γ)
end

# ╔═╡ 88294c38-039a-11eb-0da4-3f541cbe0c04
begin
	plot(M₁->ρ₂byρ₁(M₁, γ[2]), M₁min2, M₁max2,
    	      xlabel="M₁",
              ylabel="ρ₂byρ₁", 
              label="γ = $(γ[2])",
              title="Density variation",
              titlefontsize=10)
	plot!(M₁->ρ₂byρ₁(M₁, γ[1]), M₁min2, M₁max2,
		label="γ = $(γ[1])")
end

# ╔═╡ f99bbe00-0174-11eb-2cc3-7fcdc314062e
md"""
We know that for the perfect gas

$$\begin{eqnarray}
  \frac{\Delta s}{R} & = & \frac{\gamma}{\gamma-1}\ln{\frac{T_2}{T_1}} - \ln{\frac{p_2}{p_1}} \\
  & = &
  \ln{\left[\frac{\left(T_2/T_1\right)^{\gamma/(\gamma-1)}}{p_2/p_1}\right]}
    \\
    & = & \ln{\frac{p_{0_1}}{p_{0_2}}}
\end{eqnarray}$$
"""

# ╔═╡ c184b7a2-0176-11eb-2a80-cd84831d9421
function p02byp01(M₁, γ)
	exp(-ΔsbyR(M₁, γ))
end

# ╔═╡ de15fa98-0176-11eb-3ecc-d1ade030fef0
begin
	plot(M₁->p02byp01(M₁, γ[2]), M₁min2, M₁max2,
			  yaxis=:log,
    	      xlabel="M₁",
              ylabel="p02byp01", 
              label="γ = $(γ[2])",
              title="Total Pressure variation",
              titlefontsize=10)
	plot!(M₁->p02byp01(M₁, γ[1]), M₁min2, M₁max2,
			  yaxis=:log,
			  label="γ = $(γ[1])")
end

# ╔═╡ 644f49d4-017c-11eb-293c-d32c30941d09
md"To check my calculations, I will calculate $T_{0_2}/T_{0_1}$."

# ╔═╡ 86f881a8-017c-11eb-2804-d1913916e22b
function T02byT01(M₁, γ)
	T₂byT₁(M₁, γ)*( 1 + ((γ-1)*M₂(M₁,γ)^2)/2 )/( 1 + ((γ-1)*M₁^2)/2 )
end

# ╔═╡ ba64595c-017e-11eb-0e3e-0b1f8b70db7f
begin
	g=1.4
	M₁ = 4.914726387
end

# ╔═╡ 06064316-017f-11eb-0acf-83d4e338b8e5
a = 1 + ((g-1)*M₂(M₁,g)^2)/2

# ╔═╡ bcd8f512-017e-11eb-3ea1-75af0f8f4609
b = 1 + ((g-1)*M₁^2)/2

# ╔═╡ 63411616-017f-11eb-20b8-e10ec80a608d
T₂byT₁(M₁, g)

# ╔═╡ 6bca9102-017f-11eb-3567-e1a4ac9ae8c2
T₂byT₁(M₁, g)*a/b

# ╔═╡ ea9e165a-017c-11eb-235f-95b0bed7e1f0
begin
	plot(M₁->T02byT01(M₁, γ[2]), M₁min2, M₁max2,
    	      xlabel="M₁",
              ylabel="T02byT01", 
              label="γ = $(γ[2])",
              title="Total Temperature variation",
              titlefontsize=10)
end

# ╔═╡ 94c155d2-0567-11eb-2c57-2572727b4406
md"I have not been able to find the bug. $T_{0_2}/T_{0_1}$ is one everywhere but shoots up in a very narrow region of width less than $10^{-7}$. Either I am making some mistake or there is a bug in the plotting library. If you figure out, please let me know. Nevertheless, the ratio is unity everywhere else."

# ╔═╡ ecd4e25c-017d-11eb-0385-af1429e1e977
md"""

### Formula Summary

From momentum conservation,

$$\frac{p_2}{p_1} = \frac{1 + \gamma M_1^2}{1 + \gamma M_2^2}$$

From energy conservation,

$$\frac{T_2}{T_1} = \frac{1 + (\gamma-1)/2 M_1^2}{1 + (\gamma-1)/2
M_2^2}$$

From the state equation of perfect gas,

$$\frac{ρ_2}{ρ_1} =
\left(\frac{p_2}{p_1}\right)\left(\frac{T_1}{T_2}\right)$$

Prandtl's relation is

$$M_1^* M_2^* = 1$$

where,

$$M^* = \sqrt{\frac{M^2(\gamma+1)/2 }{1 + M^2(\gamma-1)/2
}}$$

From the above two equations we get

$$M_2^2 = \frac{1 + M_1^2(\gamma-1)/2 }{\gamma M_1^2 -
(\gamma-1)/2}$$

Please derive following equations using the previous relationships.

$$\begin{eqnarray}
  \frac{p_2}{p_1} & = & 1 + \frac{2\gamma}{\gamma+1}(M_1^2 -1)\\
  \frac{\rho_2}{\rho_1} & = & \frac{(\gamma+1)M_1^2}{(\gamma-1)M_1^2 + 2}
\end{eqnarray}$$
"""

# ╔═╡ Cell order:
# ╠═a178c59a-015d-11eb-34fa-bf8874f5b724
# ╠═b0fba9a6-0160-11eb-101b-331e454e74e7
# ╠═92f4b804-0164-11eb-2100-9bb8a1235639
# ╟─27d20a3c-0172-11eb-155f-cfa1bbf70998
# ╠═19556266-015d-11eb-0d66-7d868991e6f1
# ╠═e21a53ec-0161-11eb-14ff-41b6c69990a6
# ╟─f189424a-0171-11eb-1a1b-6fc1a3d7b689
# ╟─0b7b26c4-0164-11eb-3d2c-2976a7baaddb
# ╠═41b05b2e-0164-11eb-06a3-b32dec7dda7e
# ╟─418465d8-0172-11eb-3b6e-513f3f29f3d4
# ╠═5907788a-0172-11eb-29e9-a1b9e20e7f24
# ╠═4d8151ba-017d-11eb-3163-8db2ad5cf48c
# ╠═7afea4a8-0173-11eb-2132-517203f1f9ed
# ╠═b123104c-0172-11eb-1043-07aad280cce1
# ╠═4b9c4e18-0173-11eb-1abe-0905574fc87d
# ╠═88294c38-039a-11eb-0da4-3f541cbe0c04
# ╟─f99bbe00-0174-11eb-2cc3-7fcdc314062e
# ╠═c184b7a2-0176-11eb-2a80-cd84831d9421
# ╠═de15fa98-0176-11eb-3ecc-d1ade030fef0
# ╟─644f49d4-017c-11eb-293c-d32c30941d09
# ╠═86f881a8-017c-11eb-2804-d1913916e22b
# ╠═ba64595c-017e-11eb-0e3e-0b1f8b70db7f
# ╠═06064316-017f-11eb-0acf-83d4e338b8e5
# ╠═bcd8f512-017e-11eb-3ea1-75af0f8f4609
# ╠═63411616-017f-11eb-20b8-e10ec80a608d
# ╠═6bca9102-017f-11eb-3567-e1a4ac9ae8c2
# ╟─ea9e165a-017c-11eb-235f-95b0bed7e1f0
# ╟─94c155d2-0567-11eb-2c57-2572727b4406
# ╟─ecd4e25c-017d-11eb-0385-af1429e1e977
