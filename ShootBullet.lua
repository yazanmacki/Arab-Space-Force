function shootBullet()

  if common.dead then return end  

  local function angleTween( srcX, srcY, dstX, dstY )
      local angle = ( math.deg( math.atan2( dstY-srcY, dstX-srcX ) )+90 )
      return angle % 360
  end



  print(gun.rotation)
  --local line2 = display.newLine(bullet.x,bullet.y,shooterX[1],shooterY[1])

  local angle2
  local dist 
  local time2

  for i = 1,#shooterX do 
      if (shooterX[i] > left) and (shooterX[i] < right) and (shooterX[i] ~= -420) then
          dist = math.sqrt(  ( gun.x - shooterX[i] ) ^2  +  ( gun.y - shooterY[i]) ^2  )
          time2 = (dist/3580) * 1000
          print("TIME =   " .. time2)
          angle2 = angleTween(gun.x, gun.y, shooterX[i] - (time2 * common.movevelocity), shooterY[i])  
          print(gun.rotation ..  "             " .. angle2 )
          local characters = common.characters 
          if math.abs(angle2 - gun.rotation) < characters[selectedcharacter].aim then 
              gun.rotation = angle2  
              --local line2 = display.newLine(gun.x,gun.y,shooterX[i],shooterY[i])
          end
      end
  end 


  local vec = angle2Vector( gun.rotation, true )
  vec = scaleVec( vec, 5000 )

  print("TIME 1 =   " .. getTimer())

  local bullet = display.newImageRect( layers.content, weapons[selectedWeapon].bullet, weapons[selectedWeapon].bulletW, weapons[selectedWeapon].bulletH )
  bullet.x = gun.x
  bullet.y = gun.y
  bullet.gravityScale = 0
  bullet.rotation = gun.rotation
  physics.addBody( bullet, "dynamic" )
  bullet.isA = "bullet"

  if weapons[selectedWeapon].name == "bazooka" then 
      local posvec = angle2Vector( gun.rotation, true )
      posvec = scaleVec( posvec, 150 )
      makeFire(bullet.x + posvec.x,bullet.y+ posvec.y)
  end 


  bullet:setLinearVelocity( vec.x, vec.y )

  ssk.soundMgr.setVolume(0.4, "effect")

  post( "onSound", { sound = "heavyweapon" } )


  removebullet = transition.to( bullet, { alpha = 0, delay = 5000, time = 0, onComplete = display.remove } )
            
end 
