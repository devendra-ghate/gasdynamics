### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ e897ddea-033a-11eb-0fb4-09544e96bf65
begin
	using Plots, PlutoUI, LaTeXStrings
	plotly()
end

# ╔═╡ 9d4ae336-0340-11eb-1754-b7ddd40f1d6e
md"""
# Moving Normal Shock

Assume that we have a very long pipe with a piston at one end. I start moving the piston at higher and higher velocities to generate a supersonic flow. The key question I want to answer is: **What is the maxium supersonic Mach number and velocity can I generate using this method?**

---

To answer this question, first we need to derive formulas for relationship of flow properties across a moving normal shock.


*The trick here is to use stationary normal shock relationships using a coordinate transformation.*

>Thermodynamic properties do not change with the reference frame. Only the kinematic properties change. So $T$, $p$, $ρ$, $e$, $h$ and $s$ are invariant. But $u$ changes.

!!! tip "Remember"

Thermodynamic properties do not change with the reference frame. Only the kinematic properties. So $T$, $p$, $ρ$, $e$ and $s$ are invariant. But $u$ changes.

!!! warning "Question:"

What about Mach number? What about $T_0$, $p_0$ and $\rho_0$ ?

---

If $w_s$ is the speed of the normal shock then it can be shown that

$$w_s = a_1 \left( \frac{\gamma+1}{2\gamma}\frac{p_2}{p_1} +
  \frac{\gamma-1}{2\gamma} \right)^{1/2}$$

Clearly, for large perssure ratios,

```math
w_s \approx a_1 \sqrt{\frac{\gamma+1}{2\gamma}\frac{p_2}{p_1}}.
```
Also,

```math
\lim_{p_2/p_1 \rightarrow \infty} w_s = \infty.
```
The shock Mach number also keeps on increasing indefinitely.
```math
\lim_{p_2/p_1 \rightarrow \infty} M_s = \lim_{p_2/p_1 \rightarrow \infty} \frac{w_s}{a_1} = \infty.
```
"""

# ╔═╡ 538cb2ae-0349-11eb-11e7-d31e76b5c6d9
md"""

It can be shown that

```math
V_2 = w_s(1 - \frac{u_2}{u_1})
```

where, $V_2$ is the speed of the flow before the shock in the earth fixed reference frame. $u_1$ and $u_2$ are the flow speeds after and before the shock in the a reference frame moving with the shock.

!!! warning "Question"

Can I calculate the velocity before a moving shock using above expression?

---

!!! tip "Remember"

The induced velocity before a moving normal shock can be increased indefinitely.

"""

# ╔═╡ 76ce1e86-03c1-11eb-003e-c1feda575472
function a₁(T₁,γ)
	R=287 # For air
	γ*R*T₁
end

# ╔═╡ ab572a8e-03c2-11eb-2a2c-63dd5cebfefd
function M₁(p₂byp₁, γ)
	( (γ+1)/2γ * p₂byp₁ + (γ-1)/2γ )^0.5
end

# ╔═╡ ab57bdb4-03c2-11eb-3639-cb5f6a407a35
function wₛbya₁(p₂byp₁, γ)
	M₁(p₂byp₁, γ)
end

# ╔═╡ 8584990c-03c4-11eb-3b1f-c1d4053e7f01
function wₛ(p₂byp₁, T₁, γ)
	a₁(T₁,γ)*M₁(p₂byp₁, γ)
end

# ╔═╡ 519a1b1a-03c1-11eb-0966-23417cb703ca
function ρ₂byρ₁(p₂byp₁, γ)
	( (γ+1)/(γ-1)*p₂byp₁ + 1 )/( (γ+1)/(γ-1) +  p₂byp₁ )
end

# ╔═╡ afd4bffe-03c2-11eb-3d6a-e3cdda305212
function V₂(p₂byp₁, T₁, γ)
	wₛ(p₂byp₁, T₁, γ)*(1 - 1/ρ₂byρ₁(p₂byp₁, γ) )
end

# ╔═╡ 8ac81a90-06c3-11eb-3feb-959ea1514977
function V₂bya₁(p₂byp₁, γ)
	M₁(p₂byp₁, γ)*(1 - 1/ρ₂byρ₁(p₂byp₁, γ) )
end

# ╔═╡ fc48263a-0338-11eb-0f3f-df51fa28c9ad
function M₂(p₂byp₁, γ)
	( ( (γ+1)/(γ-1) + 1/p₂byp₁ )/( (γ+1)/(γ-1) + p₂byp₁ ) )^0.5 * ( p₂byp₁*(γ+1)/2γ + (γ-1)/2γ )^0.5 * (1 - ( (γ+1)/(γ-1) + p₂byp₁ )/ ( (γ+1)/(γ-1)*p₂byp₁ + 1 ) )
end

# ╔═╡ f3ba785c-033c-11eb-26f0-e3c36abb0bbd
γ = [1.2, 1.4, 1.67]

# ╔═╡ b987578a-03c2-11eb-1435-6180490eb4cf
begin
	plot(p₂byp₁->wₛbya₁(p₂byp₁, γ[2]), 1, 100,
              xlabel="p₂/p₁",
              ylabel="wₛ/a₁", 
              label="γ = $(γ[2])",
              title="Mach number of shock as a function of pressure ratio",
              titlefontsize=10)
	plot!(p₂byp₁->wₛbya₁(p₂byp₁, γ[3]), 1, 100,
		label="γ = $(γ[3])")
	
end

# ╔═╡ c1a259ee-033b-11eb-0a30-bbea0cfe599e
begin
	plot(p₂byp₁->M₂(p₂byp₁, 1.4), 1, 100,
	              xlabel="p₂/p₁",
	              ylabel="M₂", 
	              label="γ = 1.4",
				  ylims=(0,2.5),
	              title="Induced Mach number before the shock as a function of the pressure ratio",
	              titlefontsize=10)
	plot!(p₂byp₁->M₂(p₂byp₁, 1.67), 1, 100,
			label="γ = 1.67")
end

# ╔═╡ dd828d1e-063d-11eb-3858-53331343a893
md"We note here that to induced a sonic flow, much higher pressure ratio is required for a less compressible gas (i.e. a gas with higher γ)"

# ╔═╡ da632444-06c0-11eb-39fe-fda1084ea4e6
function p02byp01(p₂byp₁, γ)
	(1 + M₂(p₂byp₁, γ)^2 * (γ-1)/2)^(γ/(γ-1)) * p₂byp₁
end

# ╔═╡ 5cd86990-06c1-11eb-09de-9911be80f264
begin
	plot(p₂byp₁->p02byp01(p₂byp₁, γ[2]), 1, 100,
	              xlabel="p₂/p₁",
	              ylabel="p02/p01", 
	              label="γ = $(γ[2])",
	              title="Total pressure ratio as a function of pressure ratio",
	              titlefontsize=10)
	plot!(p₂byp₁->p02byp01(p₂byp₁, γ[3]), 1, 100,
		label="γ = $(γ[3])")
end

# ╔═╡ aad6de12-06c2-11eb-1b7d-9d25ee86e820
function T₂byT₁(p₂byp₁, γ)
	( (γ+1)/(γ-1) + p₂byp₁ )/((γ+1)/(γ-1) + 1/p₂byp₁)
end

# ╔═╡ 2bd049f4-06c3-11eb-395b-d13655b66a56
function T02byT01(p₂byp₁, γ)
	T₂byT₁(p₂byp₁, γ) + (γ-1)/2 * ( V₂bya₁(p₂byp₁, γ) )^2
end

# ╔═╡ 5c9b323e-06c2-11eb-080c-e5549feaf798
begin
	plot(p₂byp₁->p02byp01(p₂byp₁, γ[2]), 1, 30,
	              xlabel="p₂/p₁",
	              ylabel="p02/p01", 
	              label="γ = $(γ[2])",
				  #ylims=(0,6),
	              title="Total pressure ratio as a function of pressure ratio",
	              titlefontsize=10)
	plot!(p₂byp₁->p02byp01(p₂byp₁, γ[3]), 1, 30,
		label="γ = $(γ[3])")
end

# ╔═╡ 393ee51c-06c3-11eb-2a41-65d4cf3fb6c1
begin
	plot(p₂byp₁->T02byT01(p₂byp₁, γ[2]), 1, 100,
	              xlabel="p₂/p₁",
	              ylabel="T02/T01", 
	              label="γ = $(γ[2])",
				  #ylims=(0,6),
	              title="Total temperature ratio as a function of pressure ratio",
	              titlefontsize=10)
	plot!(p₂byp₁->T02byT01(p₂byp₁, γ[3]), 1, 100,
		label="γ = $(γ[3])")
end

# ╔═╡ 7a34dcc4-06c9-11eb-2af8-d35fc6033193
function ΔsbyR(p₂byp₁, γ)
		log( ( T₂byT₁(p₂byp₁, γ) )^( γ/(γ-1) ) / p₂byp₁ )
end

# ╔═╡ 6b6c5cbe-06c9-11eb-39b8-69b7b331edff
begin
	plot(p₂byp₁->ΔsbyR(p₂byp₁, γ[2]), 1, 100,
	              xlabel="p₂/p₁",
	              ylabel="Δs/R", 
	              label="γ = $(γ[2])",
				  #ylims=(0,6),
	              title="Entropy change as a function of pressure ratio",
	              titlefontsize=10)
	plot!(p₂byp₁->ΔsbyR(p₂byp₁, γ[3]), 1, 100,
		label="γ = $(γ[3])")
end

# ╔═╡ d7975344-06c9-11eb-199b-1df22015660f
begin
	plot(p₂byp₁->ΔsbyR(p₂byp₁, γ[2]), 1, 3,
	              xlabel="p₂/p₁",
	              ylabel="Δs/R", 
	              label="γ = $(γ[2])",
				  ann=[(1.25,0.01,"Nearly Isentropic region")],
	              title="Almost isentropic flow at low Mach numbers (Acoustic Theory)",
	              titlefontsize=10)
	plot!(p₂byp₁->ΔsbyR(p₂byp₁, γ[3]), 1, 3,
		label="γ = $(γ[3])")
end

# ╔═╡ d2d38c8e-06c3-11eb-0aa6-cd376e0c9cef
# TODO: plot h02/h01

# ╔═╡ Cell order:
# ╟─e897ddea-033a-11eb-0fb4-09544e96bf65
# ╟─9d4ae336-0340-11eb-1754-b7ddd40f1d6e
# ╟─538cb2ae-0349-11eb-11e7-d31e76b5c6d9
# ╟─76ce1e86-03c1-11eb-003e-c1feda575472
# ╟─ab572a8e-03c2-11eb-2a2c-63dd5cebfefd
# ╟─ab57bdb4-03c2-11eb-3639-cb5f6a407a35
# ╟─8584990c-03c4-11eb-3b1f-c1d4053e7f01
# ╟─519a1b1a-03c1-11eb-0966-23417cb703ca
# ╟─afd4bffe-03c2-11eb-3d6a-e3cdda305212
# ╟─8ac81a90-06c3-11eb-3feb-959ea1514977
# ╟─fc48263a-0338-11eb-0f3f-df51fa28c9ad
# ╟─f3ba785c-033c-11eb-26f0-e3c36abb0bbd
# ╟─b987578a-03c2-11eb-1435-6180490eb4cf
# ╟─c1a259ee-033b-11eb-0a30-bbea0cfe599e
# ╟─dd828d1e-063d-11eb-3858-53331343a893
# ╟─da632444-06c0-11eb-39fe-fda1084ea4e6
# ╟─5cd86990-06c1-11eb-09de-9911be80f264
# ╟─aad6de12-06c2-11eb-1b7d-9d25ee86e820
# ╟─2bd049f4-06c3-11eb-395b-d13655b66a56
# ╟─5c9b323e-06c2-11eb-080c-e5549feaf798
# ╟─393ee51c-06c3-11eb-2a41-65d4cf3fb6c1
# ╟─7a34dcc4-06c9-11eb-2af8-d35fc6033193
# ╟─6b6c5cbe-06c9-11eb-39b8-69b7b331edff
# ╟─d7975344-06c9-11eb-199b-1df22015660f
# ╟─d2d38c8e-06c3-11eb-0aa6-cd376e0c9cef
