### A Pluto.jl notebook ###
# v0.12.3

using Markdown
using InteractiveUtils

# ╔═╡ adb3ec5a-19fb-11eb-32da-13d6e318969c
md"""

### Theoretical

1. Show that across a stationary shock wave,

$$e_2 - e_1 = \frac{p_1 + p_2}{2}(u_1 - u_2).$$

This is called as the Hugoniot condition and it is satisfied even across
a moving shock wave.

2. For a perfect gas across a normal shock wave, show that

$$\frac{T_2}{T_1} = \frac{p_2}{p_1}\left[
  \frac{\frac{\gamma+1}{\gamma-1} + \frac{p_2}{p_1}}{1 +
\frac{\gamma+1}{\gamma-1} \frac{p_2}{p_1} }\right].$$

3. What is the upper bound on the induced velocity ($V_2$) before a moving normal shock?

4. Find an expression for the maximum induced Mach number ($M_2$) before a moving normal shock?

5. For a normal shock, show that

$$M_2^2 = \frac{2 + (γ-1)M_1^2}{2\gamma M_1^2 - (\gamma-1)}$$

$$\frac{p_2}{p_1} = 1 + \frac{2γ}{γ+1}(M_1^2 - 1)$$

$$\frac{ρ_2}{ρ_1} = \frac{(\gamma+1)M_1^2}{(\gamma-1)M_1^2 + 2}$$

$$\frac{T_2}{T_1} = \frac{2+(\gamma-1)M_1^2}{2+(\gamma-1)M_2^2}$$


6. Given two stations (A and B) in a one dimensional adiabatic duct, show that $a_A^* = a_B^*$ even if the flow in-between the stations is not in equilibrium.

7. Show that $\frac{T_{0_2}}{T_{0_1}} = 1$ for a moving normal shock in the shock reference frame.

8. If $θ = f(M_1, β)$ for an oblique shock, what is $f$ ? Here, $M_1$ is the upstream Mach number, $θ$ is the flow deflection angle and $β$ is the shock angle.

9. Show that the pressure difference across a oblique shock wave with wave angle $β$ may be expressed in the form

$$\frac{p_2 - p_1}{1/2\rho_1 u_1^2} = \frac{4}{γ+1} \left(\sin^2{\beta} - \frac{1}{M_1^2} \right)$$
"""

# ╔═╡ 4e715db2-19fc-11eb-10a7-75f7192a9d72
md"""

### Numerical

I have only picked problems from Rathakrishnan. However, this area is so fertile for problems that you will find equally good problems in any textbook (Zucker or Keith). The main thing you should focus on are the fundamentals and familiarise yourself with using the tables correctly.

#### Moving normal shock 

- Numericals by Prof. Muruganandam [YouTube](https://youtu.be/G8Qexj1EdR0?list=PLbMVogVj5nJRm6ODNAemYPS7E62_hPiqH)

- Rathakrishnan Chapter 5 problems 13, 16, 19

#### Moving normal shock reflection

- Numericals by Prof. Muruganandam [YouTube](https://youtu.be/G8Qexj1EdR0?list=PLbMVogVj5nJRm6ODNAemYPS7E62_hPiqH&t=1328)

- Rathakrishnan section 5.7 - explanation and a numerical

#### Oblique Shocks

- Olique shock numericals by Prof. Muruganandam [YouTube](https://youtu.be/9W1nOS4oDpQ?list=PLbMVogVj5nJRm6ODNAemYPS7E62_hPiqH&t=1722)

- Rathakrishnan Chapter 6 (problem 29, 30)
- Multilpe oblique shocks (Rathakrishnan example 6.7)

- Oblique shock interaction (Rathakrishnan example 6.8)


#### Fanno Flow

- Fanno flow numericals by Prof. Muruganandam [Youtube](https://www.youtube.com/watch?v=knh87LT2mJo&list=PLbMVogVj5nJRm6ODNAemYPS7E62_hPiqH&index=38)
"""

# ╔═╡ Cell order:
# ╟─adb3ec5a-19fb-11eb-32da-13d6e318969c
# ╟─4e715db2-19fc-11eb-10a7-75f7192a9d72
