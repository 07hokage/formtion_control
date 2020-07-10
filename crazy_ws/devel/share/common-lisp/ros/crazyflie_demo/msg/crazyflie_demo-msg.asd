
(cl:in-package :asdf)

(defsystem "crazyflie_demo-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "FullState" :depends-on ("_package_FullState"))
    (:file "_package_FullState" :depends-on ("_package"))
    (:file "Hover" :depends-on ("_package_Hover"))
    (:file "_package_Hover" :depends-on ("_package"))
    (:file "Position" :depends-on ("_package_Position"))
    (:file "_package_Position" :depends-on ("_package"))
    (:file "VelocityWorld" :depends-on ("_package_VelocityWorld"))
    (:file "_package_VelocityWorld" :depends-on ("_package"))
  ))