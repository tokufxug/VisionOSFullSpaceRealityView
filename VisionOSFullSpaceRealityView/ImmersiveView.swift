//
//  ImmersiveView.swift
//  VisionOSFullSpaceRealityView
//
//  Created by Sadao Tokuyama on 12/28/23.
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {
    
    var body: some View {
        RealityView { content in
            do {
                // ImageBasedLight
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.2)
                
                // Cup Entity
                let cup = try await Entity(named: "cup_saucer_set")
                cup.components.set(iblComponent)
                cup.components.set(ImageBasedLightReceiverComponent(imageBasedLight: cup))
                
                // Cup Position
                cup.position.y = cup.position.y + 0.1
                
                // Cup Shadow Component
                cup.enumerateHierarchy { child, stop in
                    if child is ModelEntity {
                        child.components.set(GroundingShadowComponent(castsShadow: true))
                    }
                }
                content.add(cup)
                
                // ToyBiplane Entity
                let toyBiplane = try await Entity(named: "toy_biplane_idle")
                toyBiplane.components.set(iblComponent)
                toyBiplane.components.set(ImageBasedLightReceiverComponent(imageBasedLight: toyBiplane))
                
                // ToyBiplane Position
                toyBiplane.position.z = toyBiplane.position.z - 0.1
                toyBiplane.position.y = toyBiplane.position.y + 0.15
                
                // ToyBiplane Animation
                if toyBiplane.availableAnimations.count > 0 {
                    toyBiplane.playAnimation(toyBiplane.availableAnimations[0].repeat())
                }
                
                // ToyBiplane Shadow Component
                toyBiplane.enumerateHierarchy { child, stop in
                    if child is ModelEntity {
                        child.components.set(GroundingShadowComponent(castsShadow: true))
                    }
                }
                content.add(toyBiplane)
            } catch {
                print("Entity encountered an error while loading the model.")
                return
            }
         }
    }
}
